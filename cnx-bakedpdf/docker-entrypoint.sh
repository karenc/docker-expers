#!/usr/bin/env bash

# This is run every time the docker container starts up.

set -e

if [ ! -d /repos/baked-pdf/node_modules ]
then
    cd /repos/baked-pdf/typeset/
    # We need to do this when the container starts up instead of at build time
    # because "npm install" adds files to /repos/baked-pdf/ which are wiped
    # when we start the container because we mount baked-pdf
    npm install
fi

exec "$@"
