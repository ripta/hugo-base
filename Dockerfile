FROM debian:bookworm-slim AS build

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
      && apt-get install -y curl unzip \
      && rm -rf /var/lib/apt/lists/*

ARG HUGO_VERSION
ARG HUGO_HASH

ENV HUGO_VERSION=$HUGO_VERSION
ENV HUGO_HASH=$HUGO_HASH
RUN mkdir /tmp/hugo \
      && cd /tmp/hugo \
      && curl -L -o hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz \
      && tar -zxf hugo.tar.gz \
      && sha1sum hugo \
      && echo "$HUGO_HASH  hugo" | sha1sum -c \
      && mv hugo /usr/bin/hugo \
      && chmod +x /usr/bin/hugo \
      && rm -rf /tmp/hugo

RUN mkdir /build
WORKDIR /build
