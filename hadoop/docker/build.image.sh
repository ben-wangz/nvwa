#! /bin/bash

set -x
set -e

IMAGE_VERSION=1.0
IMAGE=hadoop:$IMAGE_VERSION

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
docker build \
    -t $IMAGE \
    --build-arg HADOOP_DOWNLOAD_BASE_URL=${HADOOP_DOWNLOAD_BASE_URL:-https://resource.geekcity.tech/hadoop} \
    -f $SCRIPT_DIR/Dockerfile \
    $SCRIPT_DIR
