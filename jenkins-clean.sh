#!/bin/bash
docker container stop agent1 jenkins-controller
docker container prune
docker volume prune