import os
from setuptools import setup, find_packages


def read(*pathnames):
    return open(os.path.join(os.path.dirname(__file__), *pathnames)).read()

version = '1.0-beta4'

setup(name='collective.gsa64',
      version=version,
      description="Feeds protocol implementation and search integration",
      long_description='\n'.join([
          read('README.txt'),
          read('CHANGES.txt'),
          ]),
      classifiers=[
        "Framework :: Plone",
        "Framework :: Zope2",
        "Programming Language :: Python",
        ],
      keywords='plone gsa google search feeds',
      author='Malthe Borch and Mustapha Benali',
      author_email='mborch@gmail.com',
      license='GPL',
      packages=find_packages('src'),
      package_dir={'': 'src'},
      namespace_packages=['collective'],
      include_package_data=True,
      zip_safe=False,

      # If the dependency to z3c.form gives you trouble within a Zope
      # 2 environment, try the `fakezope2eggs` recipe
      install_requires=[
          'setuptools',
          'lxml',
          'plone.app.registry',
          'plone.app.controlpanel',
      ],
      entry_points="""
      [z3c.autoinclude.plugin]
      target = plone
      """,
      )
