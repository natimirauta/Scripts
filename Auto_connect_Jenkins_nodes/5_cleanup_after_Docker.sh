#!/bin/bash

NODE_NAME=$1
JENKINS_URL=$2
DOCKER_SERVICE=$3

echo "[  OK  ] Disconnecting Jenkins node ${NODE_NAME}"

java -jar /var/lib/jenkins/jenkins-cli.jar -s $JENKINS_URL disconnect-node $NODE_NAME

echo "[  OK  ] Deleting ${NODE_NAME} "

java -jar /var/lib/jenkins/jenkins-cli.jar -s $JENKINS_URL delete-node $NODE_NAME

docker service rm $DOCKER_SERVICE

