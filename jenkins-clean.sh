#!/bin/bash
docker container stop agent1 jenkins-controller
docker container prune -f
docker volume prune -f
docker network prune -f