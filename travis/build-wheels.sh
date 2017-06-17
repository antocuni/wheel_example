#!/bin/bash
set -e -x

# Compile wheels
for PYBIN in /opt/python/cp27-*/bin; do
    "${PYBIN}/pip" install 'cython>=0.25'
    "${PYBIN}/pip" wheel /io/ -w wheelhouse/

    # create the sdist if it does not exist yet
    if [[ ! -d /io/dist ]]
    then
        (cd /io && "${PYBIN}/python" setup.py sdist)
    fi
done

# Bundle external shared libraries into the wheels
for whl in wheelhouse/*.whl; do
    auditwheel repair "$whl" -w /io/wheelhouse/
done
