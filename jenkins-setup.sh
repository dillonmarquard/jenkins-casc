#!/bin/bash

# setup bridge network for jenkins
docker network create jenkins

# build jenkins-controller
docker build -t jenkins-controller .

# run jenkins-controller and open port for webserver interface
JENKINS_CONTROLLER_CONTAINER=$( docker run \
    --name jenkins-controller \
    --restart=on-failure \
    --detach \
    --network jenkins \
    --env DOCKER_HOST=tcp://docker:2376 \
    --env DOCKER_CERT_PATH=/certs/client \
    --env DOCKER_TLS_VERIFY=1 \
    --env GITHUB_REPO=https://github.com/dillonmarquard/jenkins-test.git \
    --env CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs/jenkins.yaml \
    --publish 8080:8080 \
    --publish 50000:50000 \
    --volume jenkins-data:/var/jenkins_home \
    --volume jenkins-docker-certs:/certs/client:ro \
    jenkins-controller )

echo $JENKINS_CONTROLLER_CONTAINER

#docker cp jenkins.yaml $JENKINS_CONTROLLER_CONTAINER:/var/jenkins_home/casc_configs/

JENKINS_AGENT_CONTAINER=$( docker run \
    -d --rm  \
    --name=agent1 \
    -p 22:22 \
    -e "JENKINS_AGENT_SSH_PUBKEY=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMxB6JefnIX/ZB8uOq1Qpo5+N8/E+P+CPGD3YkTcsY/M dillonmarquard@ip-10-0-0-48.ec2.internal" \
    jenkins/ssh-agent:alpine )

echo $JENKINS_AGENT_CONTAINER