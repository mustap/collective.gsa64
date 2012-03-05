from Products.CMFCore.utils import getToolByName


class RobotsViewlet(object):
    def update(self):
        props = getToolByName(self.context, 'portal_properties')
        site_properties = props['site_properties']
        self.no_archive = self.context.meta_type in site_properties.types_not_searched

    def render(self):
        if self.no_archive:
            return u'<meta name="robots" content="noarchive" />'

        return u''
