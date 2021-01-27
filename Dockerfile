FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG PUBLIC_KEY
ARG PRIVATE_KEY

RUN apt-get update && apt-get install -y sudo \
    vim \
    nano \
    git \
    nodejs \
    npm \
    build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/ubuntu && mkdir /workspace && \
    echo "ubuntu:x:${uid}:${gid}:Developer,,,:/home/ubuntu:/bin/bash" >> /etc/passwd && \
    echo "ubuntu:x:${uid}:" >> /etc/group && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
    chmod 0440 /etc/sudoers && \
    chown ${uid}:${gid} -R /home/ubuntu

ENV WORKSPACE /workspace
ENV GSDIR ${WORKSPACE}/realm-web
ENV PUBLIC_KEY ${PUBLIC_KEY}
ENV PRIVATE_KEY ${PRIVATE_KEY}
ENV PATH ${PATH}:/home/ubuntu/.npm-global/bin
RUN mkdir ${GSDIR}
RUN chown -R ubuntu ${WORKSPACE}/ && \
    chmod -R 750 ${GSDIR}/     
WORKDIR ${GSDIR}

USER ubuntu
RUN mkdir -p /home/ubuntu/.npm-global && \
    npm config set prefix /home/ubuntu/.npm-global && \
    npm --global --no-progress install mongodb-realm-cli

ENTRYPOINT ["/bin/bash", "-c"]  