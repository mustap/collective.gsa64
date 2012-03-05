Overview
========

Plone integration for Google Search Appliance.

Compatible with Plone 4.


Installation
------------

Use Plone's setup tool to install the profile: "Integration to Google
Search Appliance".

Then visit the control panel to configure your appliance. Also in the
control panel are various settings to customize the site integration.


Why?
----

This package exists to provide a light-weight integration between
Plone and a Google Search Appliance service. Its philosophy is to let
the appliance do the heavy lifting instead of Plone. The "64" postfix
corresponds to the version of the search appliance software at the
time of writing: 6.4.

There's an alternative in Matous Hora's `collective.gsa
<http://plone.org/products/collective.gsa>`_ package which takes a
different approach and is in return a much more complex piece of
software. The package also integrates more closely with Plone by
patching into the default portal catalog.

The present package -- ``collective.gsa64`` -- is about site search
and just that.


Feed protocol implementation
----------------------------

The package comes with an implementation for the `Feed Protocol API
<http://code.google.com/apis/searchappliance/documentation/68/feedsguide.html>`_. When
a content item for which search is enabled (use Plone's search control
panel to configure) is created, modified or deleted, a feed is sent to
the search appliance to update the status.

There are two modes of operation: *web* (implicitly enabled for a feed
with the name ``"web"``) and *url and metadata* mode (any other
name).

The metadata for the second mode is drawn directly from HTML using the
``plone.htmlhead`` content provider. As such this corresponds directly
to the metadata which would be indexed using crawling.

You can enable include the standard `Dublin Core
<http://plone.org/documentation/manual/theme-reference/elements/hiddenelements/plone.htmlhead.dublincore>`_
metadata using the *site* control panel.

An example of a viewlet definition in ZCML that renders additional
metadata::

  <browser:viewlet
      name="my-metadata-viewlet"
      for=".content.ISomeContentType"
      manager="plone.app.layout.viewlets.interfaces.IHtmlHead"
      template="my_metadata_viewlet.pt"
      permission="zope2.View"
      />

Note that feed requests are issued after the browser request has ended
and will not delay server response.


Search view
-----------

The setup script adds a ``Python Script`` object to the portal root
with the id ``"search"``. This takes over the normal skin lookup and
redirects the traversal to the ``@@gsa-search`` view.

You can enable or disable the search appliance results view (and
operation in general) using the control panel.

The results view is by default generated using an included browser
view with a template that generates markup similar to Plone's own
search results view. However, it's also possible to have an XSLT
transform applied directly to the XML result document and show this
instead.

For custom projects, it may be necessary to subclass the default
search view implementation. Here's an example of a modified query::

  from collective.gsa64.browser import search

  class SearchView(search.SearchView):
      def build_query(self):
          query = super(SearchView, self).build_query()

          # always include hits for "plone"
          query['q'] = '(%s) OR plone' % query['q']

          return query


It may be desirable to change the display of the individual search
results. You can accomplish this by providing your own search
templates and fill out the ``"result"`` METAL slot::

  class SearchView(search.SearchView):
      template = ViewPageTemplateFile("templates/search.pt")

      @property
      def master_search_template(self):
          return super(SearchView, self).template

The ``templates/search.pt`` template::

  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"
        xmlns:tal="http://xml.zope.org/namespaces/tal"
        xmlns:metal="http://xml.zope.org/namespaces/metal"
        xmlns:i18n="http://xml.zope.org/namespaces/i18n"
        lang="en"
        metal:use-macro="view/master_search_template/macros/master">

    <metal:result fill-slot="result">

      <h4 tal:content="structure result/heading" />

    </metal:result>

  </html>

Each ``result`` object contains the following keys:

- ``description``: HTML document description
- ``heading``: HTML document title
- ``url``: Document's display URL
- ``creator``: DC creator value
- ``normalized_content_type``: Normalized Plone content type id
- ``metadata``: Dictionary that maps metadata keys to values


Content types filter
---------------------

Plone's standard *types not searched* setting is applied to HTML
output via a browser viewlet ``"meta-robots"`` which renders a
``noarchive`` meta tag for content types excluded from search.


Credits
-------

This package was designed and developed by the following authors.

- Malthe Borch
- Mustapha Benali

Development was funded by `Headnet <http://www.headnet.dk>`_.

