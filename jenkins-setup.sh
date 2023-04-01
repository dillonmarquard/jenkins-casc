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
    -e "JENKINS_AGENT_SSH_PUBKEY=ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6hTERqmu0YT7uEbXbgghpo7sBlxme6uAOGhEB1j//XluqqyDCgpovVwyFhHfCJPIOZincc9UnxBh/P+BXSjV8/yqZW7O8Fq6fKyaEznRg27s9cfDMQ7SESJATdT+Qk0m7/dsgatQ8ogy+byGzdv575bTdz7EB1x+EVwfdXV7aHzA2VIeH+CwyHhkeOFdWe9B0jTPfQ/IDse2ykmaWhLjyQLMhHotV1vSVySsQ0CDEc+7BRCbQ89g5+WvTVUZ+nFeFv2ngCGvGD2UrmD21vJyWpfMHmJJLWC8yXVp2cmLZA1s4xrx7+2TzHXcPwL+gVbr0gi/KwWQApcKPor4X6bDSZ4e4SI3dUHiNwdK6lpezpEoRTbcsM4OD50dboFnxYP4xyTKPFDEk+TDcngdXc2hHlOK/8cImWUoRUmirRBUF9IzXJZXzYHk5qhs72C4KZ/Il+cBfP8+Id+nU4d+SHhusHErO/hxvgGRFqt+LR7JOJjxss6QcwDATFrlxA8lZdXE= jenkins@d6383a2df1c4" \
    jenkins/ssh-agent:alpine )

echo $JENKINS_AGENT_CONTAINER