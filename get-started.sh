#!/bin/bash
echo "Executing ... "
APP_NAME=${1}
if [ -z ${APP_NAME} ]
then
    read -p "MongoDB Realm Application ID (Required): " APP_NAME
fi 
docker run -it --rm \
    -p 3000:3000 \
    -v get-started-realm:/cache \
    -v "$(pwd)":/workspace \
    -w /workspace/realm-web realm-web \
    "cd realm-tutorial-web; \
    echo 'Using Application ID: ${APP_NAME}'; \
    sed -i 's/export const APP_ID = \"[-< >a-zA-Z0-9]\+\";/export const APP_ID = \"${APP_NAME}\";/g' src/App.js; \
    npm start"
