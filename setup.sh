#!/bin/bash

apt-get update
apt-get install -y git wget

PASSWORD=$1

install_miniconda () {
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    sh ./Miniconda3-latest-Linux-x86_64.sh -b
    echo ". ~/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc
    . ~/miniconda3/etc/profile.d/conda.sh
}

setup_python_environment () {
    adduser tadpole --disabled-password --gecos ""
    su tadpole
    cd
    install_miniconda
    conda create -n jupyterlab python=3
    conda install -n jupyterlab -y jupyterlab ipywidgets widgetsnbextension
    HASHED_PASSWORD=`python3 -c "from notebook.auth import passwd; print(passwd('$1'))"`
    mkdir ~/.jupyter
    envsubst < jupyter_notebook_config.py > ~/.jupyter/jupyter_notebook_config.py

    git clone https://github.com/tadpole-share/jupyter.git
    conda env update --file jupyter/environment.yml
    pip3 install -e jupyter

    # installs libraries in jupyter/lib
    for D in ~/jupyter/lib; do
        if [ -d "${D}" ]; then
            cd "~/jupyter/lib/$D"
            pip3 install -e .
        fi
    done
}

install_miniconda
setup_python_environment

cp lab.service /etc/systemd/user/