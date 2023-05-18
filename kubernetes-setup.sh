#!/bin/bash
kubectl apply -f kubernetes-setup/
minikube service jenkins-service -n devops-tools