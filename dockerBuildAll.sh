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

build () {
    cd $PROGRAM_DIR
    cd $1
    ./build.sh
}


build "Agnos/docker" && \
build "Agnos/docker/keycloak" && \
build "AgnosCubeServer/docker" && \
build "AgnosCubeServer/docker/nginx" && \
build "AgnosReportManager/docker" && \
build "AgnosReportServer/docker" && \
echo "Everything went well..."
