#! /bin/bash

set -x
set -e

IMAGE_VERSION=1.0
HADOOP_BASE_IMAGE=hadoop_base:$IMAGE_VERSION
HADOOP_NAMENODE_IMAGE=hadoop_namenode:$IMAGE_VERSION
HADOOP_DATANODE_IMAGE=hadoop_datanode:$IMAGE_VERSION

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
docker build \
    -t $HADOOP_BASE_IMAGE \
    --build-arg HADOOP_DOWNLOAD_BASE_URL=${HADOOP_DOWNLOAD_BASE_URL:-https://resource.geekcity.tech/hadoop} \
    -f $SCRIPT_DIR/base/Dockerfile \
    $SCRIPT_DIR/base
docker build \
    -t $HADOOP_NAMENODE_IMAGE \
    --build-arg HADOOP_BASE_IMAGE=$HADOOP_BASE_IMAGE \
    -f $SCRIPT_DIR/namenode/Dockerfile \
    $SCRIPT_DIR/namenode
