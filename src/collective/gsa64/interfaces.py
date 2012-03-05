import os

from zope.interface import Interface
from zope import schema
from lxml import etree

from collective.gsa64 import MessageFactory as _
from cStringIO import StringIO

def check_transform(text):
    if not text.strip():
        return True

    document = StringIO(text.encode('utf-8'))
    tree = etree.parse(document)

    try:
        etree.XSLT(tree)
    except Exception, exc:
        raise InvalidXSLTTransform(str(exc))

    return True


class IThemeSpecific(Interface):
    """ A layer specific to collective.gsa64
    """

class InvalidXSLTTransform(schema.ValidationError):
    """Invalid XSLT transform."""

    def doc(self):
        return self.args[0]


class IGeneralSettings(Interface):
    enabled = schema.Bool(
        title=_(u"Enable"),
        description=_(
            u"Integration with the Google Search Appliance is only "
            u"active when this field is set."),
        default=True
        )


class IConnectionSettings(Interface):
    name = schema.TextLine(
        title=_(u"Data source name"),
        description=_(u"This identifies the data source within the "
                      u"search appliance."),
        required=True,
        default=u"plone"
        )

    host = schema.TextLine(
        title=_(u"Host"),
        description=_(u"The hostname or IP-address of the appliance "
                      u"(e.g. 192.168.1.200, \"gsa.local\")."),
        required=True,
        default=u"",
        )

    feed_protocol_port = schema.Int(
        title=_(u"Feed protocol port"),
        description=_(u"The network port for the feed protocol service. "
                      u"Normally you do not need to change this."),
        default=19900,
        required=True,
        )

    use_secure_search = schema.Bool(
        title=_(u"Secure search"),
        description=_(u"Use SSL-encrypted search (recommended). "
                      u"You should disable this only if the appliance is "
                      u"located on a private network."),
        default=True
        )

    unsecured_search_port = schema.Int(
        title=_(u"HTTP search port"),
        description=_(u"The network port for the unsecured search service. "
                      u"This service runs on HTTP."),
        default=80,
        required=True,
        )

    secured_search_port = schema.Int(
        title=_(u"HTTPS search port"),
        description=_(u"The network port for the unsecured search service. "
                      u"This service runs on HTTPS."),
        default=443,
        required=True,
        )

    timeout = schema.Int(
        title=_(u"Time out"),
        description=_(u"The connection time-out limit in seconds."),
        default=3,
        required=True,
        )


class ISearchSettings(Interface):
    display_searchbox = schema.Bool(
        title=_(u"Display search box"),
        description=_(u"If this option is selected, a search input box "
                      u"is shown on the search page."),
        default=True,
        )

    collection = schema.TextLine(
        title=_(u"Collection"),
        description=_(u"You must define exactly one search collection."),
        required=True,
        default=u"default_collection",
        )

    frontend = schema.TextLine(
        title=_(u"Front end"),
        description=_(u"You must define exactly one front end."),
        required=True,
        default=u"default_frontend",
        )

    use_xslt_transform = schema.Bool(
        title=_(u"Use XSLT"),
        description=_(u"Apply an XSLT transform to search results "
                      u"instead of default view."),
        default=False
        )

    xslt_transform = schema.Text(
        title=_(u"XSLT transform"),
        description=_(u"This transform is applied to transform the "
                      u"search results document into HTML."),
        default=u"",
        required=False,
        )
