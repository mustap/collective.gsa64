import httplib
import lxml.etree
import lxml.html
import logging
import traceback

from zope import component
from zope.component import ComponentLookupError
from zope.security.interfaces import NoInteraction
from zope.contentprovider.interfaces import IContentProvider
from zope.annotation.interfaces import IAnnotations, IAnnotatable
from zope.pagetemplate.pagetemplatefile import PageTemplateFile
from zope.app.publication.interfaces import IEndRequestEvent
from zope.security import checkPermission
from zope.interface import providedBy
from plone.registry.interfaces import IRegistry
from Products.CMFPlone.interfaces import IPloneSiteRoot

from collective.gsa64.interfaces import IConnectionSettings
from collective.gsa64.interfaces import IGeneralSettings
from collective.gsa64.multipart import post_multipart

from AccessControl import getSecurityManager
from AccessControl.SecurityManagement import newSecurityManager
from AccessControl.SecurityManagement import noSecurityManager

feed_template = PageTemplateFile("feed.pt")

log = logging.getLogger("collective.gsa64.events")


def get_actions_for(request):
    if IAnnotatable.providedBy(request):
        annotations = IAnnotations(request)
    else:
        annotations = {}
    return annotations.setdefault("collective.gsa64.actions", {})


def set_settings(request, registry):
    settings = registry.forInterface(IConnectionSettings)
    if IAnnotatable.providedBy(request):
        IAnnotations(request).setdefault("collective.gsa64.settings", settings)


def get_settings(request):
    return IAnnotations(request).get("collective.gsa64.settings", None)


def get_metadata(context):
    request = context.REQUEST

    try:
        view = component.getMultiAdapter((context, request), name="plone")
        provider = component.getMultiAdapter(
            (context, request, view), IContentProvider, name="plone.htmlhead"
            )
    except ComponentLookupError:
        # no metadata available
        return ()

    provider.update()
    html = provider.render()

    document = lxml.html.fromstring(html)
    return tuple(
        dict(meta.attrib) for meta in document.findall('.//meta')
        )


def annotate_action(request, url, action, mimetype=None, metadata=()):
    try:
        registry = component.getUtility(IRegistry)
    except ComponentLookupError, exc:
        log.warn("Unable to get registry utility: %s." % exc)
        return

    try:
        settings = registry.forInterface(IGeneralSettings)
    except KeyError:
        return

    if settings.enabled:
        set_settings(request, registry)
        actions = get_actions_for(request)
        actions[url] = (action, url, mimetype, metadata)


def annotate_add(context):    
    if IPloneSiteRoot in providedBy(context):
        return

    annotate_action(
        context.REQUEST,
        context.absolute_url(),
        "add",
        context.getContentType(),
        get_metadata(context),
        )


def verify_anonymous(context):
    user = getSecurityManager().getUser()
    noSecurityManager()

    try:
        return checkPermission("zope2.View", context)
    except NoInteraction:
        return False
    finally:
        newSecurityManager(None, user)


def handle_created_event(context, event):
    if verify_anonymous(event.object):
        annotate_add(event.object)


def handle_modified_event(context, event):
    if verify_anonymous(event.object):
        annotate_add(event.object)
    else:
        annotate_action(
            context.REQUEST,
            event.object.absolute_url(),
            "delete",
            )


def handle_removed_event(context, event):
    if event.oldParent and event.oldName:
        annotate_action(
            context.REQUEST,
            event.oldParent.absolute_url() + "/" + event.oldName,
            "delete"
            )


def handle_moved_event(context, event):
    handle_removed_event(context, event)

    if event.newParent is not None:
        context = event.newParent[event.newName]
        if verify_anonymous(context):
            annotate_add(context)


@component.adapter(IEndRequestEvent)
def publish_feed(event):
    records = []
    settings = get_settings(event.request)

    if settings is None:
        return

    actions = {}
    for kind, url, mimetype, metadata in get_actions_for(event.request).values():
        actions.setdefault(kind, []).append({
            'url': url,
            'mimetype': mimetype,
            'metadata': metadata,
            })

    if not actions:
        return

    include_metadata = (settings.name != "web")
    if include_metadata:
        feedtype = "metadata-and-url"
    else:
        feedtype = "incremental"

    # Too big to fail! (Or rather, this event handler must not fail or
    # the thread will hang indefinitely).
    try:
        content = feed_template(
            feedtype=feedtype,
            name=settings.name,
            actions=actions,
            include_metadata=include_metadata,
            )

        content = content.encode('ascii', 'xmlcharrefreplace')

        # Set up HTTP connection to feed protocol service
        conn = httplib.HTTP(settings.host, settings.feed_protocol_port)

        # Not part of public API
        conn._conn.timeout = 3

        data = "data", "feed.xml", content
        params = [
            ("feedtype", "metadata-and-url"),
            ("datasource", settings.name)
            ]
        result = post_multipart(conn, "/xmlfeed", params, (data,))

        if result != 'Success':
            log.warn(result)

    except Exception, exc:
        log.warn(traceback.format_exc())
