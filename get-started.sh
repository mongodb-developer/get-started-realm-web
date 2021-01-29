#!/bin/bash
echo "Executing ... "
APP_NAME=${1}

docker run -it --rm \
    -p 3000:3000 \
    -v "$(pwd)":/workspace \
    -w /workspace/realm-web realm-web \
    "cd realm-tutorial-web; \
    sed -i 's/export const APP_ID = \"[< >a-zA-Z0-9]\+\";/export const APP_ID = \"${APP_NAME}\";/g' src/App.js;
    npm install; npm start"
