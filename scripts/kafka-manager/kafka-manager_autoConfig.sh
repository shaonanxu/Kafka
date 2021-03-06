#!/bin/bash
export JAVA_HOME=/opt/jdk
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
zkConect=$(cat /opt/kafka/config/server.properties |grep zookeeper.connect= |awk -F = '{print $2}')
zk=`echo $zkConect |awk -F / '{print $1}'`
nameSpace=`echo $zkConect |awk -F / '{print $2}'`
cluster_id=`echo $zkConect |awk -F / '{print $3}'`
/opt/zookeeper/bin/zkCli.sh  -server ${zk} create /kafka-manager/configs/$cluster_id '{"name":"'"$cluster_id"'","curatorConfig":{"zkConnect":"'"$zkConect"'","zkMaxRetry":100,"baseSleepTimeMs":100,"maxSleepTimeMs":1000},"enabled":true,"kafkaVersion":"0.10.1.0","jmxEnabled":true,"jmxUser":null,"jmxPass":null,"jmxSsl":false,"pollConsumers":false,"filterConsumers":false,"logkafkaEnabled":false,"activeOffsetCacheEnabled":false,"displaySizeEnabled":false,"tuning":{"brokerViewUpdatePeriodSeconds":30,"clusterManagerThreadPoolSize":10,"clusterManagerThreadPoolQueueSize":100,"kafkaCommandThreadPoolSize":10,"kafkaCommandThreadPoolQueueSize":100,"logkafkaCommandThreadPoolSize":2,"logkafkaCommandThreadPoolQueueSize":100,"logkafkaUpdatePeriodSeconds":30,"partitionOffsetCacheTimeoutSecs":5,"brokerViewThreadPoolSize":30,"brokerViewThreadPoolQueueSize":1000,"offsetCacheThreadPoolSize":30,"offsetCacheThreadPoolQueueSize":1000,"kafkaAdminClientThreadPoolSize":30,"kafkaAdminClientThreadPoolQueueSize":1000}}'
/opt/zookeeper/bin/zkCli.sh  -server ${zk}  quit

