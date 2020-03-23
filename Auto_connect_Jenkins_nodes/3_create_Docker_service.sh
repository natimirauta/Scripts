#!/bin/bash

SERVICE_NAME=$1
SECRET=$2
NODE_NAME=$3
JENKINS_URL=$4

DOCKER_REGISTRY_LINK=192.168.1.9:5000
DOCKER_IMAGE_NAME=ubuntu_slave
DOCKER_IMAGE_VER=v3

DOCKER_IMAGE=$DOCKER_REGISTRY_LINK/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VER

SERVICE_REPLICAS=1

echo "[  OK  ] Creating Docker service"

whoami

docker service create --name=$SERVICE_NAME --replicas=$SERVICE_REPLICAS $DOCKER_IMAGE

echo "[  OK  ] Done creating Docker service"

sh ./4_connect_service_to_node.sh $SERVICE_NAME $SECRET $NODE_NAME $JENKINS_URL

