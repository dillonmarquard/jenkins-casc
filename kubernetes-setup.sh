#!/bin/bash

kubectl apply -f kubernetes/serviceAccount.yaml
kubectl apply -f kubernetes/volume.yaml
kubectl apply -f kubernetes/service.yaml

kubectl apply -f kubernetes/volume-setup.yaml # create pod to load initial jenkins volume setup
sleep 3
POD=$(kubectl get pods -n devops-tools -o name | cut -c5-) # remove `pod/` prefix from string

kubectl exec -n devops-tools $POD -- sh -c 'mkdir -p /var/jenkins_home/casc_configs/'
kubectl cp jenkins.yaml devops-tools/$POD:/var/jenkins_home/casc_configs/jenkins.yaml
kubectl cp .ssh devops-tools/$POD:/var/jenkins_home/.ssh

kubectl delete -f kubernetes/volume-setup.yaml # delete jenkins volume setup pod
sleep 3

kubectl apply -f kubernetes/controller-deployment.yaml
kubectl apply -f kubernetes/agent-deployment.yaml

# open connection to k8 servie in minikube
minikube service jenkins-service -n devops-tools