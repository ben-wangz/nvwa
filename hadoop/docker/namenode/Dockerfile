ARG HADOOP_BASE_IMAGE=hadoop-base:1.0
FROM $HADOOP_BASE_IMAGE
COPY entry-point.sh /opt/hadoop/entry/namenode/entry-point.sh
RUN chmod u+x /opt/hadoop/entry/namenode/entry-point.sh
ENV FORMAT_NAMENODE=false

CMD ["/opt/hadoop/entry/namenode/entry-point.sh"]
