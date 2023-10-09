#!/bin/bash

# This script's directory, relative to the running point
RELATIVE_SCRIPT_DIR=$( dirname -- ${BASH_SOURCE[0]} )

# This script's absolute directory
SCRIPT_DIR=$( cd -- ${RELATIVE_SCRIPT_DIR} &> /dev/null && pwd )

# Read the local configured variables
cd ${SCRIPT_DIR}
source ./env.txt

# Build the container using the local Dockerfile
docker build -t ${TARGET_CONTAINER_NAME} .
