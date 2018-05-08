#!/bin/bash

function logger(){
    if [[ "$1" == 'INFO' ]]; then
        echo -e "\e[35m[INFO]: $2"
        tput sgr0
    elif [[ "$1" == 'SUCCESS' ]]; then
        echo -e "\e[32m[SUCCESS]: $2"
        tput sgr0
    elif [[ "$1" == 'WARNING' ]]; then
        echo -e "\e[93m[WARNING]: $2"
        tput sgr0
    elif [[ "$1" == 'ERROR' ]]; then
        echo -e "\e[91m[ERROR]: $2"
        tput sgr0
    else
        echo "$@"
        tput sgr0
    fi
}

function graceful_terminate {
    logger 'INFO' 'Gracefully stopping tanker...'
    exit 0
}

function fowardPortHostMinikube {
    MINIKUBE_IS_FOWARDED=$(VBoxManage showvminfo minikube | grep "host port = ${1}" || false)
    if [[ -z "${MINIKUBE_IS_FOWARDED}" || "${MINIKUBE_IS_FOWARDED}" == '' ]]; then
        logger 'INFO' "Fowarding minikube service port ${1} to host..."
        VBoxManage controlvm "minikube" natpf1 "guestsvc,tcp,,${1},,${1}"
        logger 'SUCCESS' "Finished configuration to foward port ${1} between host and minikube"
    else
        logger 'INFO' "Found existent NAT rule, skipping fowarding configuration..."
    fi
    logger 'INFO' "You may be able to access the application directly by: http://localhost:${1}"
    logger 'INFO' "You may also be able to access Dashboard directly by: http://localhost:${MINIKUBE_DASHBOARD_PORT}"
}