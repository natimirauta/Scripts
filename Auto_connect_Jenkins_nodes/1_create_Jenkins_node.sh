#!/bin/bash

NODE_NAME=$1
JENKINS_URL=$2
JOB_NAME=$3
BUILD_NUMBER=$4

SERVICE_NAME_FILE=service_name.txt
SERVICE_NAME=$JOB_NAME-$BUILD_NUMBER

CONFIG_NAME=config
NODE_CONFIG_FILE_NAME=$CONFIG_NAME.xml
NUMBER_OF_EXECUTORS=3
NODE_HOME=/home/Jenkins

rm -f $NODE_CONFIG_FILE_NAME

echo "<?xml version='1.1' encoding='UTF-8'?>" >> $NODE_CONFIG_FILE_NAME
echo "<slave>" >> $NODE_CONFIG_FILE_NAME
  echo "<name>${NODE_NAME}</name>" >> $NODE_CONFIG_FILE_NAME
  echo "<description></description>" >> $NODE_CONFIG_FILE_NAME
  echo "<remoteFS>${NODE_HOME}</remoteFS>" >> $NODE_CONFIG_FILE_NAME
  echo "<numExecutors>${NUMBER_OF_EXECUTORS}</numExecutors>" >> $NODE_CONFIG_FILE_NAME
  echo "<mode>NORMAL</mode>" >> $NODE_CONFIG_FILE_NAME
  echo "<retentionStrategy class=\"hudson.slaves.RetentionStrategy$Always\"/>" >> $NODE_CONFIG_FILE_NAME
  echo "<launcher class=\"hudson.slaves.JNLPLauncher\">" >> $NODE_CONFIG_FILE_NAME
    echo "<workDirSettings>" >> $NODE_CONFIG_FILE_NAME
      echo "<disabled>false</disabled>" >> $NODE_CONFIG_FILE_NAME
      echo "<internalDir>remoting</internalDir>" >> $NODE_CONFIG_FILE_NAME
      echo "<failIfWorkDirIsMissing>false</failIfWorkDirIsMissing>" >> $NODE_CONFIG_FILE_NAME
    echo "</workDirSettings>" >> $NODE_CONFIG_FILE_NAME
  echo "</launcher>" >> $NODE_CONFIG_FILE_NAME
  echo "<label></label>" >> $NODE_CONFIG_FILE_NAME
  echo "<nodeProperties/>" >> $NODE_CONFIG_FILE_NAME
echo "</slave>" >> $NODE_CONFIG_FILE_NAME

java -jar /var/lib/jenkins/jenkins-cli.jar -s $JENKINS_URL create-node < $NODE_CONFIG_FILE_NAME

rm -f $NODE_CONFIG_FILE_NAME

sh ./2_get_secrets.sh $NODE_NAME $SERVICE_NAME $JENKINS_URL
