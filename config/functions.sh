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
    MINIKUBE_IS_FOWARDED=$(VBoxManage showvminfo minikube | grep "host port = ${2}" 2>/dev/null || false)
    if [[ -z "${MINIKUBE_IS_FOWARDED}" || "${MINIKUBE_IS_FOWARDED}" == '' ]]; then
        logger 'INFO' "Forwarding minikube service port ${2} to host..."
        VBoxManage controlvm "minikube" natpf1 "${1},tcp,,${2},,${2}"
        logger 'SUCCESS' "Finished configuration to forward port ${2} between host and minikube"
    else
        logger 'INFO' "Found existent NAT rule, skipping forwarding configuration..."
    fi
    logger 'INFO' "You may be able to access the application directly by: http://localhost:${2}"
    logger 'INFO' "You may also be able to access Dashboard directly by: http://localhost:${MINIKUBE_DASHBOARD_PORT}"
}