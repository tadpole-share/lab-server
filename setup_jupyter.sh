#!/bin/bash
install_miniconda () {
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    sh ./Miniconda3-latest-Linux-x86_64.sh -b
    echo ". ~/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc
    . ~/miniconda3/etc/profile.d/conda.sh
}

cd
install_miniconda
conda create -n tadpole python=3 -y # fails first time
conda create -n tadpole python=3 -y
conda activate tadpole

# Jupyterlab stuff
conda install -c conda-forge -n tadpole -y jupyterlab ipywidgets widgetsnbextension nodejs psutil
jupyter labextension install @jupyter-widgets/jupyterlab-manager
pip install psutil

# Tadpole stuff
git clone https://github.com/tadpole-share/jupyter.git
conda env update --file jupyter/environment.yml
pip install -e jupyter

## installs libraries in jupyter/lib
cd /home/tadpole/jupyter/lib
for D in */; do
    if [ -d "${D}" ]; then
        pip install -e "$D"
        pip install -r "$D/requirements.txt"
    fi
done

cd /home/tadpole/jupyter
pip install -e .

# R stuff
conda install -c r r