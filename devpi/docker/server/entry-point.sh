#! /bin/bash

set -x
set -e

DEVPI_ROOT_PASSWORD=${DEVPI_ROOT_PASSWORD:-YeqwHPNz9VUWB2bn}
SERVIER_DIR=${SERVIER_DIR:-/app/devpi/server}
LISTEN_HOST=${LISTEN_HOST:-0.0.0.0}
LISTEN_PORT=${LISTEN_PORT:-3141}

if [ ! -f "${SERVIER_DIR}/.serverversion" ]; then
    devpi-init --serverdir=${SERVIER_DIR} --root-passwd "${DEVPI_ROOT_PASSWORD}"
fi
exec devpi-server --serverdir=${SERVIER_DIR} --host ${LISTEN_HOST} --port ${LISTEN_PORT} --restrict-modify=root
