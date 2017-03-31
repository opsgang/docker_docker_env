FROM debian:jessie

MAINTAINER Levent Yalcin <leventyalcin [at] gmail >

LABEL name="docker_env" version="1.0.0" \
      description="Docker client for building images through CD/CI"

ENV DEBIAN_FRONTEND=noninteractive \
    DOCKER_VERSION="1.12.3-0" \
    DOCKER_APT_URI="https://apt.dockerproject.org/repo" \
    CLEANUP_DIRS="/var/cache/apt/archives/ /var/lib/apt/*"

USER root

RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates \
    && apt-key adv \
      --keyserver hkp://p80.pool.sks-keyservers.net:80 \
      --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo "deb ${DOCKER_APT_URI} debian-jessie main" \
            > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-engine=${DOCKER_VERSION}~jessie jq make python-pip \
    && pip install -U awscli \
    && rm -rf $CLEANUP_DIRS
