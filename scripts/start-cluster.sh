#!/bin/bash

# Check if minikube is installed
if ! command -v minikube &> /dev/null; then
    echo "Error: minikube is not installed"
    echo "Please install minikube first: https://minikube.sigs.k8s.io/docs/start/"
    exit 1
fi

minikube start -p k8s-homelab --memory=2912 --cpus=4 --driver=docker 

minikube profile k8s-homelab