#!/bin/bash
mkdir -p .ssh
ssh-keygen -q -t ed25519 -f ./.ssh/jenkins-ssh