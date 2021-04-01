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
echo "Setting up environment ..."
docker run --rm \
    -v "$(pwd)":/workspace \
    -w /home/ubuntu ghcr.io/mongodb-developer/get-started-realm-web:0.1 \
    "sed -i 's/\"clusterName\": \"[a-zA-Z0-9]\+\"/\"clusterName\": \"${CLUSTER_NAME}\"/g' realm-tutorial-backend/services/mongodb-atlas/config.json;
     realm-cli login --api-key ${PUBLIC_KEY} --private-api-key ${PRIVATE_KEY}; \
     realm-cli import --yes --path ./realm-tutorial-backend && \
     echo 'You can now execute get-started.sh <APP ID>';"
