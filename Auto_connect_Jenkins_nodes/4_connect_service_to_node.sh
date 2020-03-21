#!/bin/bash

SERVICE_NAME=$1
SECRET=$2
NODE_NAME=$3
JENKINS_URL=$4

MAIN_HOST_NAME=nati-Aspire-V3-772G

HOST_IP=192.168.99.100
SECURE_PORT=2376

TASK_ID="$(sudo docker service ps ${SERVICE_NAME} -q)"
NODE_ID="$(sudo docker inspect --format {{.NodeID}} ${TASK_ID})"
CONTAINER_ID="$(sudo docker inspect --format {{.Status.ContainerStatus.ContainerID}} ${TASK_ID})"
NODE_HOST="$(sudo docker inspect --format {{.Description.Hostname}} ${NODE_ID})"

TLS_VERIFY="1"
DOCKER_HOST_IP="tcp://${HOST_IP}:${HOST_PORT}"
DOCKER_NODE_CERT_PATH="/home/nati/.docker/machine/machines/${NODE_HOST}"

CMD_CONNECT="java -jar /home/agent.jar -jnlpUrl ${JENKINS_URL}/computer/${NODE_NAME}/slave-agent.jnlp -secret ${SECRET} -workDir \"/home/Jenkins\""

[ $NODE_HOST = $MAIN_HOST_NAME ] && sudo docker exec -it $CONTAINER_ID $CMD_CONNECT
[ $NODE_HOST != $MAIN_HOST_NAME ] && eval $(docker-machine env $NODE_HOST) && docker exec -d $CONTAINER_ID $CMD_CONNECT

