# Jenkins CI/CD Example     

## Goals
I wanted to demonstrate how to setup and configure a Jenkins controller + agent using the configuration-as-code plugin.     
This supports a more scalable architecture that can be reproduced at any time from scratch.
Maintaining Jenkins through the UI is time-consuming and tedious, so this project aims to provide a skeleton for building out more maintainable jenkins environments.

## Requirements
docker:^20.10.17    
kubectl:^1.25.4    
minikube:^1.30.1    
    
## Setup 
generate ssh permissions for worker node(s) (no passphrase)     
./gen-ssh.sh  
  
create .ssh/github-personal-token and paste your github PAT token with repo access
  
## Run with Kubernetes
./kubernetes-setup.sh
    
## Kubernetes Cloud Configuration    
* in-progress    
    
## Run with Docker
./jenkins-setup.sh  
    
Enter IP of the agent (most likely your private ip, but you can host the agent elsewhere) (hostname -i doesnt work on mac)
    
## Docker Cloud Configuration
    
### EC2 Instance 
    
#### Network Security
* 80 (jenkins webserver)
* 4444 (agent ssh)
* 22 (ec2 ssh)
