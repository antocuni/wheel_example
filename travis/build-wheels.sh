#!/bin/bash
set -e -x

PYBIN=/opt/python/
# Compile wheels
for PYBIN in /opt/python/cp27-*/bin; do
    "${PYBIN}/pip" install 'cython>=0.25'
    "${PYBIN}/pip" wheel /io/ -w wheelhouse/
done

# Bundle external shared libraries into the wheels
for whl in wheelhouse/*.whl; do
    auditwheel repair "$whl" -w /io/wheelhouse/
done
