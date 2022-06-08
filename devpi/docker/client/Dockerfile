ARG BASE_CENTOS_IMAGE=docker.io/python:3.9.12-buster
FROM $BASE_CENTOS_IMAGE
ARG PIP_REGISTRY=https://mirrors.aliyun.com/pypi/simple
RUN set -x \
        && pip install devpi-client==5.2.3 -i $PIP_REGISTRY \
        && useradd devpi
COPY entry-point.sh /app/devpi/entry-point.sh
RUN chmod a+x /app/devpi/entry-point.sh

USER devpi
WORKDIR /app/
CMD ["/app/devpi/entry-point.sh"]
