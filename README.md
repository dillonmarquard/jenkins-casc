# Jenkins CI/CD Example     

## Goals
I wanted to demonstrate how to setup and configure a jenkins controller using the configuration-as-code plugin.     
This supports a more scalable architecture that can be reproduced at any time.
Maintaining a Jenkins home directory does not scale 

## Requirements
docker:^20.10.22

## Setup
generate ssh permissions for slave node (no passphrase)     
./gen-ssh.sh    

./jenkins-setup.sh  

## Configuration

