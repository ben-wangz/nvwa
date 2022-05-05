#! /bin/bash

function add_property(){
    local FILE_PATH=$1
    local NAME=$2
    local VALUE=$3

    local ENTRY="<property><name>$NAME</name><value>${VALUE}</value></property>"
    local ESCAPED_ENTRY=$(echo $ENTRY | sed 's/\//\\\//g')
    sed -i "/<\/configuration>/ s/.*/${ESCAPED_ENTRY}\n&/" $FILE_PATH
}

function configure() {
    local FILE_PATH=$1
    local ENV_PREFIX=$2

    echo "Configuring $FILE_PATH ..."
    typeset -p | awk '$3 ~ "^"ENV_PREFIX { print $3 }' ENV_PREFIX="$ENV_PREFIX" | sed "s/^$ENV_PREFIX//" \
        | while read line || [[ -n $line ]]
    do
        echo "parsing $line"
        local NAME=$( \
            echo $line | awk -F= '{print $1}' | sed -e "s/___/-/g" -e "s/__/\x01/g" -e "s/_/./g" -e "s/\x01/_/g")
        local VALUE=$(echo $line | awk -F= '{ st = index($0,"=");print substr($0,st+1)}' | sed -e 's/^"//' -e 's/"$//')
        echo "set '$NAME'='$VALUE'"
        add_property $FILE_PATH $NAME "$VALUE"
    done
}

set -e

configure $HADOOP_CONF_DIR/core-site.xml CORE_CONF_
configure $HADOOP_CONF_DIR/hdfs-site.xml HDFS_CONF_
configure $HADOOP_CONF_DIR/yarn-site.xml YARN_CONF_
configure $HADOOP_CONF_DIR/httpfs-site.xml HTTPFS_CONF_
configure $HADOOP_CONF_DIR/kms-site.xml KMS_CONF_

echo "starting... $NODE_ROLE"
case "$NODE_ROLE" in
   "NameNodeFormatter")
   ;;
   "NameNodeWithFormatter")
       $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format $CLUSTER_NAME
       exec $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode $@
   ;;
   "NameNode")
       exec $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode $@
   ;;
   "DataNode")
       exec $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR datanode $@
   ;;
   "SecondaryNameNode")
       exec $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR secondarynamenode $@
   ;;
   "ResourceManager")
   ;;
   "NodeManager")
   ;;
   "WebAppProxy")
   ;;
   "MapReduceJobHistoryServer")
   ;;
esac


