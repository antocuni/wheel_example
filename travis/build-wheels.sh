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

# install pypy
(cd /opt; tar xf /io/travis/pypy*.tar.bz2)
PYPY=/opt/pypy*/bin/pypy
$PYPY -m ensurepip
$PYPY -m pip install -U pip setuptools wheel

# compile wheels for pypy
$PYPY -m pip install 'cython>=0.25'
$PYPY -m pip wheel /io/ -w wheelhouse/


# Bundle external shared libraries into the wheels
for whl in wheelhouse/*.whl; do
    auditwheel repair --plat manylinux2010_x86_64 "$whl" -w /io/wheelhouse/
done
