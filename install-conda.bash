#!/bin/bash
# This downloads and installs a pinned version of miniconda
set -e

CONDA_VERSION=4.3.21
URL="https://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh"
INSTALLER_PATH=/usr/local/sbin/miniconda-installer

wget --quiet $URL -O ${INSTALLER_PATH}
chmod +x ${INSTALLER_PATH}

# Only MD5 checksums are available for miniconda
# Can be obtained from https://repo.continuum.io/miniconda/
MD5SUM="c1c15d3baba15bf50293ae963abef853"

if ! echo "${MD5SUM}  ${INSTALLER_PATH}" | md5sum  --quiet -c -; then
    echo "md5sum mismatch for ${INSTALLER_PATH}, exiting!"
    exit 1
fi

${INSTALLER_PATH} -f -b -p ${CONDA_DIR}

# Allow easy direct installs from conda forge
${CONDA_DIR}/bin/conda config --system --add channels conda-forge

# Do not attempt to auto update conda
${CONDA_DIR}/bin/conda config --system --set auto_update_conda false

# Clean things out!
${CONDA_DIR}/bin/conda clean -tipsy

# Remove the big installer so we don't increase docker image size too much
rm ${INSTALLER_PATH}

chown -R $NB_USER:$NB_USER ${CONDA_DIR}
