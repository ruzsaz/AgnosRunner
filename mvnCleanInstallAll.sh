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

# Load the static variables
source ${SCRIPT_DIR}/init_variables.sh

# Load the personal settings
source ${SCRIPT_DIR}/environment.txt

mvn clean install --file ../AgnosCube/pom.xml && \
mvn clean install --file ../AgnosMolap/pom.xml && \
mvn clean install --file ../AgnosReport/pom.xml && \
mvn clean install --file ../AgnosCubeDriver/pom.xml && \
mvn clean install --file ../AgnosCubeMeta/pom.xml && \
mvn clean install --file ../AgnosCubeServer/pom.xml && \
mvn clean install --file ../AgnosReportManager/pom.xml && \
mvn clean install --file ../AgnosReportServer/pom.xml && \
echo "Everything went well..."