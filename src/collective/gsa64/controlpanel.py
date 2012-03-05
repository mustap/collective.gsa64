from zope.component import getUtility
from zope.interface import alsoProvides
from collective.gsa64 import MessageFactory as _
from plone.registry.interfaces import IRegistry
from plone.registry.recordsproxy import RecordsProxy
from plone.app.registry.browser import controlpanel

from z3c.form import field
from z3c.form import group
from z3c.form import widget
from z3c.form.browser import text

from .interfaces import IConnectionSettings
from .interfaces import ISearchSettings
from .interfaces import IGeneralSettings


class ISettings(IGeneralSettings, IConnectionSettings, ISearchSettings):
    """Common control panel interface."""


class ConnectionSettingsGroup(group.Group):
    label = _(u"Connection settings")
    fields = field.Fields(IConnectionSettings)


class SearchSettingsGroup(group.Group):
    label = _(u"Search settings")
    fields = field.Fields(ISearchSettings)


class AbstractRecordsProxy(object):
    def __init__(self, schema):
        state = self.__dict__
        state["__registry__"] = getUtility(IRegistry)
        state["__proxies__"] = {}
        state["__schema__"] = schema
        alsoProvides(self, schema)

    def __getattr__(self, name):
        try:
            field = self.__schema__[name]
        except KeyError:
            raise AttributeError(name)
        else:
            proxy = self._get_proxy(field.interface)
            return getattr(proxy, name)

    def __setattr__(self, name, value):
        try:
            field = self.__schema__[name]
        except KeyError:
            self.__dict__[name] = value
        else:
            proxy = self._get_proxy(field.interface)
            return setattr(proxy, name, value)

    def __repr__(self):
        return "<AbstractRecordsProxy for %s>" % self.__schema__.__identifier__

    def _get_proxy(self, interface):
        proxies = self.__proxies__
        return proxies.get(interface) or \
               proxies.setdefault(interface, self.__registry__.\
                                  forInterface(interface))


class EditForm(controlpanel.RegistryEditForm):
    schema = ISettings
    fields = field.Fields(IGeneralSettings)
    groups = ConnectionSettingsGroup, SearchSettingsGroup
    label = _(u"Settings for integration with Google Search Appliance")

    def getContent(self):
        return AbstractRecordsProxy(self.schema)


class ControlPanel(controlpanel.ControlPanelFormWrapper):
    form = EditForm
