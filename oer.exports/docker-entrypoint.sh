#!/usr/bin/env bash

# This is run every time the docker container starts up.

set -e

if [ ! -d /repos/oer.exports/node_modules ]
then
    . $HOME/.nvm/nvm.sh
    cd /repos/oer.exports/
    # We need to do this when the container starts up instead of at build time
    # because ./script/setup adds files to /repos/oer.exports/ which are wiped
    # when we start the container because we mount ./oer.exports
    ./script/setup
fi

exec "$@"
