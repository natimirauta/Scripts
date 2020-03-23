#!/bin/bash

NODE_NAME=$1
SERVICE_NAME=$2
JENKINS_URL=$3

API_TOKEN=11215f6b5f16e617b8c7b5be646392076e
JENKINS_ACCOUNT=natimirauta
JENKINS_PW=admin    

CRUMB_FILE=crumb.txt
SECRET_FILE=secret.txt

echo "[  OK  ] Getting crumb..."

curl -u "${JENKINS_ACCOUNT}:${API_TOKEN}" $JENKINS_URL/crumbIssuer/api/xml | sed 's/\(.*\)<crumb>// ; s/<\/crumb>\(.*\)//' > $CRUMB_FILE

CRUMB="$(cat ${CRUMB_FILE})"

echo "[  OK  ] Got crumb : ${CRUMB}"
rm -f $CRUMB_FILE

echo "Getting secret..."

curl -L -s -u $JENKINS_ACCOUNT:$JENKINS_PW -H "Jenkins-Crumb:${CRUMB}" -X GET $JENKINS_URL/computer/$NODE_NAME/slave-agent.jnlp | sed 's/\(.*\)<application-desc main-class=\"hudson.remoting.jnlp.Main\"><argument>// ; s/<\/argument><argument>\(.*\)//' > $SECRET_FILE

SECRET="$(cat ${SECRET_FILE})"

echo "[  OK  ] Got secret : ${SECRET}"
rm -f $SECRET_FILE

sh ./3_create_Docker_service.sh $SERVICE_NAME $SECRET $NODE_NAME $JENKINS_URL

