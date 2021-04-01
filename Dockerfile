FROM ubuntu:20.04

LABEL org.opencontainers.image.source=https://github.com/mongodb-developer/get-started-realm-web

ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/home/ubuntu \ 
    PATH=${PATH}:/home/ubuntu/.npm-global/bin

RUN useradd -ms /bin/bash ubuntu && \
    apt-get update && apt-get install -y npm git && \
    rm -rf /var/lib/apt/lists/*

USER ubuntu

RUN mkdir -p ${HOME}/.npm-global && \
    npm config set prefix ${HOME}/.npm-global && \
    npm --global --no-progress install mongodb-realm-cli;\
    cd ${HOME};\
    git clone --depth 1 https://github.com/sindbach/realm-tutorial-backend.git;\
    git clone --depth 1 https://github.com/sindbach/realm-tutorial-web.git;\
    cd ${HOME}/realm-tutorial-web;\
    npm install;

ENTRYPOINT ["/bin/bash", "-c"]