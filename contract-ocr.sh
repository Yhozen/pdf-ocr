#!/bin/bash

###############   Parameters  ###################
IMAGE_NAME=contract-ocr

RED="\e[31m"
LIGHT_RED="\e[91m"
ENDCOLOR="\e[0m"
############# ------------------ ################

############# Check dependencies ################
echo -n "Checking dependencies... "
for name in realpath docker
do
  [[ $(which $name 2>/dev/null) ]] || { echo -en "${RED}\n$name needs to be installed. Use 'sudo apt-get install $name'${ENDCOLOR}";deps=1; }
done
[[ $deps -ne 1 ]] && echo "OK" || { echo -en "${LIGHT_RED}\nInstall the above and rerun this script\n${ENDCOLOR}";exit 1; }
############# ------------------ ################

###############  Build image  ###################
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
    echo "Building image"
    docker build . -t $IMAGE_NAME
  # do something
fi
############# ------------------ ################

################  Run image  ####################
CONTRACT_PATH=$(realpath $1);
docker run -v "$CONTRACT_PATH:/opt/build/input/input.pdf" $IMAGE_NAME
############# ------------------ ################
