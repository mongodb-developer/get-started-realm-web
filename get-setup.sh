#!/bin/bash
PUBLIC_KEY=${1}
PRIVATE_KEY=${2}

if [ -z ${PUBLIC_KEY} ]
then
    read -p "MongoDB Atlas Public Key (Required): " PUBLIC_KEY
fi 
if [ -z ${PRIVATE_KEY} ]
then
    read -p "MongoDB Atlas Private Key (Required): " PRIVATE_KEY
fi 

CLUSTER_NAME=${3:-"Cluster0"}

echo "Executing ... "

docker run --rm \
    -v "$(pwd)":/workspace \
    -w /workspace/realm-web realm-web \
    "git clone --depth 1 https://github.com/sindbach/realm-tutorial-backend.git; \
     git clone --depth 1 https://github.com/sindbach/realm-tutorial-web.git; \
     sed -i 's/\"clusterName\": \"[a-zA-Z0-9]\+\"/\"clusterName\": \"${CLUSTER_NAME}\"/g' realm-tutorial-backend/services/mongodb-atlas/config.json;
     realm-cli login --api-key ${PUBLIC_KEY} --private-api-key ${PRIVATE_KEY}; \
     realm-cli import --yes --path ./realm-tutorial-backend > realm-import.txt 2>&1; \
     cat realm-import.txt; \
     NEWAPP=\`grep -r 'Successfully imported ' realm-import.txt | awk '{print $3}'\`; \
     echo 'Now you can execute \"get-started.sh ${NEWAPP}\"';"
