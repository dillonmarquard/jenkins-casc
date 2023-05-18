#!/bin/bash
docker container stop jenkins-controller agent_489hvbic agent_4o9ch2bxv
docker container rm jenkins-controller agent_489hvbic agent_4o9ch2bxv
docker volume prune -f
docker network rm jenkins