#!/bin/bash

# Clear the terminal screen
clear

# Change to 'export all env variables' mode
set -o allexport

# This script's directory, relative to the running point
RELATIVE_SCRIPT_DIR=$( dirname -- ${BASH_SOURCE[0]} )

# This script's absolute directory
SCRIPT_DIR=$( cd -- ${RELATIVE_SCRIPT_DIR} &> /dev/null && pwd )

# Base directory of the Agnos programs (parent of the script's dir)
PROGRAM_DIR="$(dirname ${SCRIPT_DIR})"

# Load the personal settings
source ${SCRIPT_DIR}/environment.txt

push () {
    cd $PROGRAM_DIR
    cd $1
    source ./env.txt
    docker push ${TARGET_CONTAINER_NAME}
}


push "Agnos/docker" && \
push "Agnos/docker/keycloak" && \
push "AgnosCubeServer/docker" && \
push "AgnosCubeServer/docker/nginx" && \
push "AgnosReportManager/docker" && \
push "AgnosReportServer/docker" && \
echo "Everything went well..."
