#!/bin/bash
HOST_IP=$(curl -s ifconfig.me)
read -p "Enter AGENT IP: " AGENT_IP
PUB_KEY=$(cat .ssh/jenkins-ssh.pub)

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
    --env HOST_IP=$HOST_IP \
    --env LOCAL_IP=$LOCAL_IP \
    --env AGENT_IP=$AGENT_IP \
    --env JAVA_OPTS=-Djenkins.install.runSetupWizard=false \
    --publish 80:8080 \
    --publish 50000:50000 \
    --volume jenkins-data:/var/jenkins_home \
    --volume jenkins-docker-certs:/certs/client:ro \
    jenkins-controller )

# run jenkins agent
JENKINS_AGENT_CONTAINER1=$( docker run \
    -d --rm  \
    --name=agent_489hvbic \
    --network jenkins \
    -p 4444:22 \
    -e "JENKINS_AGENT_SSH_PUBKEY=$PUB_KEY" \
    jenkins/ssh-agent:alpine )

JENKINS_AGENT_CONTAINER2=$( docker run \
    -d --rm  \
    --name=agent_4o9ch2bxv \
    --network jenkins \
    -p 4445:22 \
    -e "JENKINS_AGENT_SSH_PUBKEY=$PUB_KEY" \
    jenkins/ssh-agent:alpine )


echo $JENKINS_CONTROLLER_CONTAINER
echo $JENKINS_AGENT_CONTAINER1
echo $JENKINS_AGENT_CONTAINER2