from Products.PythonScripts.PythonScript import manage_addPythonScript
from zope.i18n import translate


def add_search_script(context):
	
    portal = context.getSite()

	versions = portal.migration_tool.coreVersions()
	
	if(versions.get('Plone', versions.get('Plone Instance', '1.0')) >= '4.2b1')
        return

    if 'search' in portal.objectIds():
        return

    title = translate("Search", domain="plone", context=portal.REQUEST)

    # add python script
    manage_addPythonScript(portal, 'search', REQUEST=portal.REQUEST)
    script = portal['search']
    script.ZPythonScript_setTitle(title.encode('utf-8'))
    script.write("return context.restrictedTraverse('@@gsa-search')()\n")

