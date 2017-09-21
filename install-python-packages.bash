#!/bin/bash
set -e
# Install most of the python packages we might use,
# from conda or pip
# NOTE: Please keep package lists alphabetically sorted

# FIXME: Decide on an upgrade policy for these packages
# FIXME: Decide on inclusion policy for these packages

# Basic useful scientific packages
${CONDA_DIR}/bin/conda install --quiet --yes \
            bokeh \
            cloudpickle \
            cython \
            dill \
            h5py \
            hdf5 \
            matplotlib \
            numba \
            numexpr \
            pandas \
            patsy \
            scikit-image \
            scikit-learn \
            scipy \
            seaborn \
            sqlalchemy \
            statsmodels \
            sympy

# Pre-generate font cache so the user does not see fc-list warning when
# importing datascience. https://github.com/matplotlib/matplotlib/issues/5836
${CONDA_DIR}/bin/python -c 'import matplotlib.pyplot'

${CONDA_DIR}/bin/conda install --quiet --yes numpy

# Remove pyqt and qt, since we do not need them with notebooks
${CONDA_DIR}/bin/conda remove --quiet --yes --force qt pyqt

${CONDA_DIR}/bin/conda install --quiet --yes setuptools
${CONDA_DIR}/bin/pip install --upgrade virtualenv virtualenvwrapper \
	    ipykernel \
	    pipenv \
	    nbdime \
	    pandoc \
	    six

${CONDA_DIR}/bin/pip install  \
	    https://github.com/jupyter/notebook/zipball/master \
	    https://github.com/jupyterlab/jupyterlab/zipball/master \
	    https://github.com/jupyterhub/jupyterhub/zipball/master

git ls-remote https://github.com/jupyterlab/jupyterlab.git master | \
    awk '{print $1}' > /root/jupyterlab.commit

${CONDA_DIR}/bin/conda clean -tipsy
