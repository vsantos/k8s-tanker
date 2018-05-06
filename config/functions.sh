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