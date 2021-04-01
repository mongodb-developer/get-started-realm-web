#!/bin/bash
echo "Executing ... "
APP_ID=${1}
if [ -z ${APP_ID} ]
then
    read -p "MongoDB Realm Application ID (Required): " APP_ID
fi 
docker run -it --rm \
    -p 3000:3000 \
    -v "$(pwd)":/workspace \
    -w /home/ubuntu/realm-tutorial-web ghcr.io/mongodb-developer/get-started-realm-web:0.1 \
    "echo 'Using Application ID: ${APP_ID}'; \
    sed -i 's/export const APP_ID = \"[-< >a-zA-Z0-9]\+\";/export const APP_ID = \"${APP_ID}\";/g' src/App.js; \
    npm start"
