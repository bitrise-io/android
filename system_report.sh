#!/bin/bash
set -e

echo
echo "=== Revision / ID ======================"
echo "* BITRISE_DOCKER_REV_NUMBER_ANDROID: $BITRISE_DOCKER_REV_NUMBER_ANDROID"
echo "========================================"
echo

# Make sure that the reported version is only
#  a single line!
echo
echo "=== Pre-installed tool versions ========"

ver_line="$(gradle --version | grep 'Gradle ')" ;     echo "* Gradle: $ver_line"
ver_line="$(mvn --version | grep 'Apache Maven')" ;   echo "* Maven: $ver_line"
ver_line="$( javac -version 2>&1 )" ;                 echo "* Java: $ver_line"

echo "========================================"
echo

echo
echo "=== Android tools/dirs ================="
echo
echo "* build-tools:"
ls -1 ${ANDROID_HOME}/build-tools
echo
echo "* extras:"
tree -L 2 ${ANDROID_HOME}/extras
echo
echo "* platforms:"
ls -1 ${ANDROID_HOME}/platforms
echo
echo "* system-images:"
tree -L 3 ${ANDROID_HOME}/system-images
echo "========================================"
echo
