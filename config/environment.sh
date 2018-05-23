#!/bin/bash

DEBUG=false

EXPOSE_DASHBOARD=true

MINIKUBE_CLIENT_VERSION='v0.27.0'
#MINIKUBE_DRIVER=kvm2
MINIKUBE_DRIVER=virtualbox
MINIKUBE_DASHBOARD_PORT=30000
KUBERNETES_DEPLOY_NAMESPACE=development
KUBERNETES_RBAC=true

# List of k8s applications which will be deployed by tanker
# Ex: KUBE_APPS(wordpress-sample api-java api-crm)
declare -a KUBE_APPS
KUBE_APPS=(wordpress-sample)
