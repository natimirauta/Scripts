#!/bin/bash

SERVICE_NAME=$1
SECRET=$2
NODE_NAME=$3
JENKINS_URL=$4

MAIN_HOST_NAME=nati-Aspire-V3-772G

TASK_ID="$(docker service ps ${SERVICE_NAME} -q)"
NODE_ID="$(docker inspect --format {{.NodeID}} ${TASK_ID})"
CONTAINER_ID="$(docker inspect --format {{.Status.ContainerStatus.ContainerID}} ${TASK_ID})"
NODE_HOST="$(docker inspect --format {{.Description.Hostname}} ${NODE_ID})"

CMD_CONNECT="java -jar /home/agent.jar -jnlpUrl ${JENKINS_URL}/computer/${NODE_NAME}/slave-agent.jnlp -secret ${SECRET} -workDir \"/home/Jenkins\""

echo $TASK_ID
echo $NODE_ID
echo $CONTAINER_ID
echo $NODE_HOST
echo $CMD_CONNECT

[ $NODE_HOST = $MAIN_HOST_NAME ] && docker exec -it $CONTAINER_ID $CMD_CONNECT
[ $NODE_HOST != $MAIN_HOST_NAME ] && eval $(docker-machine env $NODE_HOST) && docker exec -d $CONTAINER_ID $CMD_CONNECT

