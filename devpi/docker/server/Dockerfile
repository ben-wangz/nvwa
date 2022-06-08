ARG BASE_CENTOS_IMAGE=docker.io/python:3.9.12-buster
FROM $BASE_CENTOS_IMAGE
ARG PIP_REGISTRY=https://mirrors.aliyun.com/pypi/simple
RUN set -x \
        && pip install \
            devpi-server==6.5.1 \
            devpi-web==4.0.8 \
            -i $PIP_REGISTRY \
        && useradd devpi \
        && mkdir -p /app/devpi \
        && chown devpi:devpi /app/devpi
COPY entry-point.sh /app/devpi/entry-point.sh
RUN chmod a+x /app/devpi/entry-point.sh

USER devpi
WORKDIR /app/
CMD ["/app/devpi/entry-point.sh"]
