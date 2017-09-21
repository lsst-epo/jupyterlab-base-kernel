FROM bitnami/minideb:latest

MAINTAINER J. Matt Peterson <jmatt@lsst.org>

# Install all OS dependencies for notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
RUN apt-get update
ADD install-base-apt.bash /usr/local/sbin/install-base-apt.bash
RUN /usr/local/sbin/install-base-apt.bash

# Generate the en_US UTF-8 Locale, and set that to be
# the default locale. Otherwise it'll default to the 8bit C
# locale, and cause problems any time we use characters that
# are not 8-bit ASCII.
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Set the default shell to bash, rather than sh
ENV SHELL /bin/bash

# Configure Environment
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV NB_USER jovyan
ENV NB_UID 1000

# Since we put NLTK data in /opt rather than /usr/local,
# we have to explicitly set this
ENV NLTK_DATA ${CONDA_DIR}/nltk

# We want to pre-generate the matplotlib font-list cache
# in a way that keeps the cache in the docker image (since
# $HOME is mounted in a persistent volume). We do this by
# making matplotlib keep its cache (and other config too - but
# we don't care about that for now) in /var/cache by setting
# the environment variable MPLCONFIGDIR. We then import
# matplotlib's pyplot later to trigger this caching behavior.
# NOTE: This can be done away with once we use MPL 2
ENV MPLCONFIGDIR=/var/cache/matplotlib

# Create a jovyan user with UID 1000. It also automatically
# creates a group with GID 1000 named jovyan
RUN adduser --gecos '' --shell /bin/bash --uid $NB_UID --disabled-password $NB_USER 

# Install conda into $CONDA_DIR, and chown it to $NB_USER
ADD install-conda.bash /usr/local/sbin/install-conda.bash
RUN /usr/local/sbin/install-conda.bash


ADD install-publishing-apt.bash /usr/local/sbin/install-python-packages.bash
RUN /usr/local/sbin/install-python-packages.bash


ADD install-publishing-apt.bash /usr/local/sbin/install-publishing-apt.bash
RUN /usr/local/sbin/install-publishing-apt.bash
