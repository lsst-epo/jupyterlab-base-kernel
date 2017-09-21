#!/bin/bash
set -e

# Install publishing apt packages.
install_packages \
    inkscape \
    libsm6 \
    libxrender1 \
    pandoc \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-xetex \
    imagemagick

# For matplotlib animation
install_packages \
    libav-tools
