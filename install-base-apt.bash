#!/bin/bash
set -e

# Install base apt packages.
install_packages \
    python3-dev \
    git \
    build-essential \
    locales \
    bzip2\
    ca-certificates \
    curl \
    wget \
    lynx-cur \
    patch \
    less \
    rsync \
    openssh-client \
    ruby \
    rename \
    netbase \
    libsasl2-modules \
    tk \
    zlib1g-dev \
    gettext \
    libextutils-makemaker-cpanfile-perl \
    sudo \
    unzip \
    gnupg2 \
    vim \
    emacs-nox

# Install a newer verison of nodejs and npm.
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
install_packages nodejs
npm install bower -g
