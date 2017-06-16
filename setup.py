import sys
import os
from setuptools import setup, find_packages, Extension
from Cython.Build import cythonize


setup(name="wheel_example",
      author='Antonio Cuni',
      author_email='anto.cuni@gmail.com',
      url='https://github.com/antocuni/wheel_example',
      use_scm_version=True,
      packages = find_packages(),
      ext_modules = cythonize('wheel_example/module.pyx'),
      setup_requires=['setuptools_scm'],
      zip_safe=False,
)
