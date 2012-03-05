import os
import time
import httplib
import logging
import urllib
import lxml.etree

from Products.Five.browser.pagetemplatefile import ViewPageTemplateFile
from Products.Five.browser import BrowserView
from Products.CMFPlone.utils import normalizeString
from Acquisition import aq_inner
from zExceptions import NotFound

from zope import component
from plone.memoize.view import memoize_contextless
from plone.memoize import ram
from plone.registry.interfaces import IRegistry
from collective.gsa64.interfaces import IGeneralSettings
from collective.gsa64.interfaces import IConnectionSettings
from collective.gsa64.interfaces import ISearchSettings
from collective.gsa64 import MessageFactory as _


log = logging.getLogger("collective.gsa64.search")

trivial_search = lxml.etree.parse(
    open(os.path.join(os.path.dirname(__file__), 'trivial.xml'), 'rb'))


def get_connection():
    registry = component.getUtility(IRegistry)
    settings = registry.forInterface(IConnectionSettings)

    if settings.use_secure_search:
        conn = httplib.HTTPSConnection(
            settings.host,
            settings.secured_search_port,
            timeout=settings.timeout,
            )
    else:
        conn = httplib.HTTPConnection(
            settings.host,
            settings.unsecured_search_port,
            timeout=settings.timeout,
            )

    return conn


class SearchView(BrowserView):
    """Search view.

    The functionality is split out into smaller methods and properties
    to allow easy customization.

    In particular ``build_query`` returns the query that is sent to
    the GSA to request search results.
    """

    template = ViewPageTemplateFile("search.pt")

    error = None

    estimated_results = 0

    @property
    def __call__(self):
        if self.enabled:
            return self.template

        # fall back to default search skin
        skin = self.context.portal_skins.getSkin()
        template = getattr(skin, 'search', None)

        # it may not exist
        if template is None:
            raise NotFound('search')

        # aq-wrap in current context and return
        return template.__of__(self.context)

    @property
    def enabled(self):
        registry = component.getUtility(IRegistry)
        settings = registry.forInterface(IGeneralSettings)
        return settings.enabled

    @memoize_contextless
    def get_settings(self):
        registry = component.getUtility(IRegistry)
        return registry.forInterface(ISearchSettings)

    def get_collection(self):
        return self.get_settings().collection

    def get_frontend(self):
        return self.get_settings().frontend

    @property
    def display_searchbox(self):
        return self.get_settings().display_searchbox

    @memoize_contextless
    def get_language(self):
        return self.portal_state.language().encode('utf-8')

    @property
    def use_transform(self):
        return self.get_settings().use_xslt_transform

    @property
    def search_terms(self):
        return self.request.form.get('SearchableText') or \
               self.request.form.get('q', '')

    @property
    def search_query(self):
        return self.query['q']

    @property
    @memoize_contextless
    def query(self):
        return self.build_query()

    @property
    @memoize_contextless
    def results(self):
        iter = self.iter_results()
        return tuple(iter)

    @property
    @memoize_contextless
    def url(self):
        return self.request.getURL()

    @property
    @memoize_contextless
    def portal_state(self):
        context = aq_inner(self.context)
        return component.getMultiAdapter(
            (context, self.request), name=u'plone_portal_state'
            )

    @property
    def dynamic_navigation(self):
        results = []

        document = self._get_results()
        for element in document.findall('.//PMT'):
            results.append(
                (element.attrib['NM'],
                 element.attrib['DN'],
                 dict(
                     (category.attrib['V'], int(category.attrib['C']))
                     for category in element.findall('PV')
                     )
                 ))

        return results

    def build_query(self):
        query = self.request.form.copy()

        # main query
        query['q'] = self.search_terms

        # determine current language
        query['hl'] = self.get_language()

        # request full metadata fields
        query['getfields'] = '*'

        # XML output
        query['output'] = 'xml_no_dtd'

        # encoding
        query['ie'] = 'UTF-8'
        query['oe'] = 'UTF-8'

        # search collection
        query['site'] = self.get_collection()

        # search frontend
        query['client'] = self.get_frontend()

        # only public access is supported
        query['access'] = 'p'

        # don't filter results
        query['filter'] = 0

        return query

    @memoize_contextless
    def _get_results(self):
        t = time.time()

        try:
            response = self._make_request(self.query)

            if response.status == 200:
                document = lxml.etree.parse(response)
                elapsed = time.time() - t

                try:
                    self.estimated_results = int(document.find('.//M').text)
                    query_time = float(document.find('.//TM').text)
                except AttributeError:
                    query_time = -1

                log.info(
                    "received %d search results in %3.3f seconds " % (
                        self.estimated_results, elapsed) +
                    "(query time: %3.3f seconds)." % query_time
                    )

                return document
            else:
                reason = "Bad server response (%d %s)" % (
                    response.status, response.reason)
                log.warn(reason)
        except IOError, exc:
            log.warn(exc)
            reason = str(exc)

        self.error = _("An error occurred during search: ${message}.",
                       mapping={'message': reason})

        return trivial_search

    def _make_request(self, query):
        conn = get_connection()
        try:
            conn.request(
                "GET",
                "/search?%s" % urllib.urlencode(query),
                headers={
                    'Accept-language': self.get_language(),
                    }
                )
            response = conn.getresponse()
        except IOError, exc:
            self.error = _("Search is unavailable: ${message}.",
                           mapping={'message': str(exc)})
            raise

        return response

    def navigation(self):
        document = self._get_results()
        info = document.find('.//NB')
        if info is not None:
            next = info.find('.//NU')
            prev = info.find('.//PU')

            return {
                'next': next is not None and "%s?%s" % (
                    self.url, next.text.split('?', 1)[1]),
                'prev': prev is not None and "%s?%s" % (
                    self.url, prev.text.split('?', 1)[1]),
                }

    def iter_results(self):
        document = self._get_results()
        for result in document.findall('.//R'):
            metadata = dict(
                (result.attrib['N'], result.attrib['V'])
                for result in result.xpath('MT')
                )

            portal_type = metadata.get('DC.type', 'missing')
            normalized_type = normalizeString(portal_type)

            heading = result.xpath('T/text()')
            if heading:
                heading = heading[0]
            url = result.xpath('UD|U/text()')[0]
            description = result.xpath('S/text()')
            if description:
                description = description[0]


            yield {
                # standard fields
                'description': description or "",
                'heading': heading or url,
                'url': url,

                # standard Plone DC metadata
                'creator': metadata.get('DC.creator'),
                'normalized_content_type': 'contenttype-' + normalized_type,

                # include metadata dictionary for 3rd party
                # customization
                'metadata': metadata,
                }

    def get_keymatch(self):
        document = self._get_results()
        keymatchs = []
        for result in document.findall('.//GM'):
            url = result.xpath("GL/text()")[0]
            title = result.xpath("GD/text()")[0]
            keymatchs.append({'title': title, 'url': url})
        return keymatchs

    @ram.cache(lambda method, self, body: body)
    def get_xslt(self, body):
        encoded = body.encode('utf-8')
        document = lxml.etree.fromstring(encoded)
        return lxml.etree.XSLT(document)

    def render_transformed(self):
        settings = self.get_settings()
        transform = self.get_xslt(settings.xslt_transform)

        # request search results document
        document = self._get_results()

        # apply transform
        result = transform(document)

        return lxml.etree.tostring(result)
