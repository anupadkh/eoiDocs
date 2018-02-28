#!/usr/bin/env python3
from setuptools import setup, find_packages
setup(name='eoiDocs',
    version='0.0.1',
    description='''
    Hobbs ElectroOptics/ElectroOptical Innovations Document Generator
    ''',
    url='https://hobbs-eo.com',
    author='Hobbs ElectroOptics',
    author_email='simon.hobbs@hobbs-eo.com',
    license='BSD',
    packages=find_packages(),
    install_requires=[
        'pyfiglet',
        'click',
        'pylatex',
    ],
    test_suite='nose.collector',
    tests_require=['nose'],
    scripts=['bin/eoiDocs'],
    package_data = {
        'eoiDocs.tex' : ['*'],
        'tex': ['*']
    },
    include_package_data=True,
    zip_safe=True)
