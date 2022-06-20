#! /bin/bash

set -x
set -e

DEVPI_SERVER_SCHEMA=${DEVPI_SERVER_SCHEMA:-http}
DEVPI_SERVER_HOST=${DEVPI_SERVER_HOST:-host.docker.internal}
DEVPI_SERVER_PORT=${DEVPI_SERVER_PORT:-3141}
DEVPI_USERNAME=${DEVPI_USERNAME:-root}
DEVPI_INDEX=${DEVPI_INDEX:-root/pypi}
DEVPI_ROOT_PASSWORD=${DEVPI_ROOT_PASSWORD:-YeqwHPNz9VUWB2bn}
CLIENT_DIR=${CLIENT_DIR:-/tmp/devpi/client}
MIRROR_URL=${MIRROR_URL:-https://mirrors.aliyun.com/pypi/simple}
MIRROR_WEB_URL_FMT=${MIRROR_WEB_URL_FMT:-https://mirrors.aliyun.com/pypi/simple}
INITIALIZE_INDEX_MIRROR=${INITIALIZE_INDEX_MIRROR:-false}

devpi --clientdir ${CLIENT_DIR} use ${DEVPI_SERVER_SCHEMA}://${DEVPI_SERVER_HOST}:${DEVPI_SERVER_PORT}/${DEVPI_INDEX}
devpi login --clientdir ${CLIENT_DIR} --password ${DEVPI_ROOT_PASSWORD} ${DEVPI_USERNAME}
if [ "true" = "${INITIALIZE_INDEX_MIRROR}" ]; then
    devpi --clientdir ${CLIENT_DIR} \
        index ${DEVPI_INDEX} \
        "mirror_url=${MIRROR_URL}" \
        "mirror_web_url_fmt=${MIRROR_WEB_URL_FMT}"
else
    tail -f /etc/hosts
fi
