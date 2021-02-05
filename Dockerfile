FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG PUBLIC_KEY
ARG PRIVATE_KEY

RUN apt-get update && apt-get install -y \
    git \
    npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash ubuntu 

ENV WORKSPACE /workspace
ENV GSDIR ${WORKSPACE}/realm-web
ENV PUBLIC_KEY ${PUBLIC_KEY}
ENV PRIVATE_KEY ${PRIVATE_KEY}
ENV PATH ${PATH}:/home/ubuntu/.npm-global/bin

RUN mkdir -p ${GSDIR} && chown -R ubuntu ${WORKSPACE}/ && \
    chmod -R 750 ${GSDIR}/     
WORKDIR ${GSDIR}

USER ubuntu
RUN mkdir -p /home/ubuntu/.npm-global && \
    npm config set prefix /home/ubuntu/.npm-global && \
    npm --global --no-progress install mongodb-realm-cli

ENTRYPOINT ["/bin/bash", "-c"]  