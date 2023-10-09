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

# Create the log's directory, and donate it to the group guid 1000
# (logstash group inside the container)
# Be sure the user is member in the group on the host!!!
mkdir ${LOG_FILES_DIRECTORY}
chown :1000 ${LOG_FILES_DIRECTORY}
chmod 775 ${LOG_FILES_DIRECTORY}
chmod g+s ${LOG_FILES_DIRECTORY}


# Restore to normal env variable mode
set +o allexport

# Start the docker compose process
docker-compose up
