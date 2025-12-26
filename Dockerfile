FROM node:lts-alpine AS base
LABEL maintainer="Bharat Rajagopalan <bharatrajagopalan@gmail.com>" \
      description="Lightweight Docusaurus container with Node.js based on Alpine Linux"

# Environment variable from .env via docker compose
ARG PUID
ARG PGID
ARG USER
ARG AUTO_UPDATE
ARG TEMPLATE

USER root

RUN \
    corepack enable && \
    apk add --no-cache \
                        bash bash-completion supervisor \
                        autoconf automake build-base libtool nasm git && \  
    echo ${PUID} ${PGID} ${USER} && \
    addgroup -g ${PGID} ${USER} || true && \
    adduser -D -u ${PUID} -G `getent group ${PGID} | cut -d: -f1` ${USER} || true

USER ${PUID}:${PGID}
RUN \
    cd /home/${USER} && \
    npx --yes create-docusaurus@latest docusaurus ${TEMPLATE} --typescript && \
    cd /home/${USER}/docusaurus && \
    npm install --save-dev \
                        typescript \
                        @docusaurus/module-type-aliases \
                        @docusaurus/tsconfig \
                        @docusaurus/types  \
                        rehype-extended-table && \
    npm install --save \
                        @docusaurus/theme-mermaid \ 
                        remark-math@6 rehype-katex@7 \
                        @docusaurus/theme-live-codeblock \
                        @mermaid-js/layout-elk \
                        docs-to-pdf \
                        raw-loader && \
#Required to support  deploy function
    git config --global --add safe.directory /home/${USER}/docusaurus/docs

WORKDIR /home/${USER}/docusaurus
