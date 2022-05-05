ARG BASE_CENTOS_IMAGE=centos:centos8.4.2105
FROM $BASE_CENTOS_IMAGE
ARG HADOOP_VERSION=3.3.2
ARG HADOOP_DOWNLOAD_BASE_URL=https://archive.apache.org/dist/hadoop/common
ARG HADOOP_HOME_PREFIX=/opt/hadoop
RUN rm -f /etc/yum.repos.d/*
COPY centos.8.stream.repo /etc/yum.repos.d/
ENV JAVA_HOME=/etc/alternatives/java_sdk_11 \
    HADOOP_VERSION=$HADOOP_VERSION \
    HADOOP_HOME=$HADOOP_HOME_PREFIX/current \
    HADOOP_CONF_DIR=$HADOOP_HOME_PREFIX/current/etc/hadoop \
    PATH=$PATH:$HADOOP_HOME_PREFIX/current/bin \
    CLUSTER_NAME=hadoop
RUN set -x \
        && mkdir -p /opt/hadoop \
        && HADOOP_TAR_GZ=/opt/hadoop/hadoop-$HADOOP_VERSION.tar.gz \
        && curl -o $HADOOP_TAR_GZ -L $HADOOP_DOWNLOAD_BASE_URL/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
        && tar zxf $HADOOP_TAR_GZ -C /opt/hadoop \
        && rm -f $HADOOP_TAR_GZ \
        && ln -s /opt/hadoop/hadoop-$HADOOP_VERSION /opt/hadoop/current
RUN set -x \
    && dnf -y install java-11-openjdk-devel
COPY entry-point.sh /opt/hadoop/entry/namenode/entry-point.sh
RUN chmod u+x /opt/hadoop/entry/namenode/entry-point.sh

CMD ["/opt/hadoop/entry/namenode/entry-point.sh"]
WORKDIR /opt/hadoop/current
