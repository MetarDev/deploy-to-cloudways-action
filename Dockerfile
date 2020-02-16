# Container image that runs your code
FROM node:lts-alpine

RUN apk add --no-cache \
  openssh-client \
  ca-certificates \
  git \
  wget \
  curl \
  rsync \
  php7 \
  php7-curl \
  php7-openssl \
  php7-iconv \
  php7-json \
  php7-mbstring \
  php7-phar \
  php7-dom \
  bash && \
  mkdir -p ~/.ssh

# Setup composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
