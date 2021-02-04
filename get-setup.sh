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

echo "Creating get-started-realm Docker volume ... "
docker volume create get-started-realm 
docker run --rm \
    -v get-started-realm:/cache \
    --user root:0 realm-web \
    "mkdir /cache/realm-web; \
    chown -R ubuntu:ubuntu /cache/realm-web;"
echo "Setting up environment ..."
docker run --rm \
    -v get-started-realm:/cache \
    -v "$(pwd)":/workspace \
    -w /workspace/realm-web realm-web \
    "git clone --depth 1 https://github.com/sindbach/realm-tutorial-backend.git; \
     git clone --depth 1 https://github.com/sindbach/realm-tutorial-web.git; \
     mkdir /cache/realm-web/node_modules; \
     ln -s /cache/realm-web/node_modules /workspace/realm-web/realm-tutorial-web/node_modules; \
     cd /workspace/realm-web/realm-tutorial-web/; \
     echo 'Performing npm install, this may take a while ...'
     npm install --force; \
     cd /workspace/realm-web; \
     sed -i 's/\"clusterName\": \"[a-zA-Z0-9]\+\"/\"clusterName\": \"${CLUSTER_NAME}\"/g' realm-tutorial-backend/services/mongodb-atlas/config.json;
     realm-cli login --api-key ${PUBLIC_KEY} --private-api-key ${PRIVATE_KEY}; \
     realm-cli import --yes --path ./realm-tutorial-backend; \
     echo 'You can now execute get-started.sh <APP NAME>';"
