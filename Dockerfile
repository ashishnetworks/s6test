FROM node:16

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./

# Not for everybody, just in case you need LOCAL crt autority
COPY *.crt /etc/ssl/certs/
RUN update-ca-certificates

RUN npm config set strict-ssl=false

# Installs S6-overlay process initializer
ARG S6_OVERLAY_VERSION=3.1.1.1
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN unxz /tmp/s6-overlay-noarch.tar.xz
RUN tar xf /tmp/s6-overlay-noarch.tar -C /
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN unxz /tmp/s6-overlay-x86_64.tar.xz
RUN tar xf /tmp/s6-overlay-x86_64.tar -C /
RUN chmod +x /init

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN npm install
COPY . .
ENTRYPOINT ["/init"]

EXPOSE 3000
CMD [ "node", "server.js" ]