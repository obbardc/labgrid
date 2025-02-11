#!/bin/sh

set -ex
if [ -z ${DOCKER} ]; then
    command -v docker >/dev/null 2>&1 && DOCKER=docker
fi
if [ -z ${DOCKER} ]; then
    command -v podman >/dev/null 2>&1 && DOCKER=podman
fi
export DOCKER_BUILDKIT=1

VERSION="$(python -m setuptools_scm)"

for t in client exporter coordinator; do
    ${DOCKER} build --build-arg VERSION="$VERSION" \
        --target labgrid-${t} -t labgrid-${t} -f dockerfiles/Dockerfile .
done
