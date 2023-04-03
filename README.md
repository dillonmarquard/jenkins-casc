# Jenkins CI/CD Example     

## Goals
I wanted to demonstrate how to setup and configure a Jenkins controller + agent using the configuration-as-code plugin.     
This supports a more scalable architecture that can be reproduced at any time from scratch.
Maintaining Jenkins through the UI is time-consuming and tedious. 

## Requirements
docker:^20.10.17

## Setup
generate ssh permissions for slave node (no passphrase)     
./gen-ssh.sh    

create .ssh/github-personal-token and paste your github PAT token with repo access

./jenkins-setup.sh  

Enter IP of the agent (most likely your private ip, but you can host the agent elsewhere) (hostname -i doesnt work on mac)

## Configuration

## EC2 Instance 

### Network Security
* 80 (jenkins webserver)
* 4444 (agent ssh)
* 22 (ec2 ssh)
