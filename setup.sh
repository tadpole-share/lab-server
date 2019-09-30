#!/bin/bash
apt-get update
apt-get install -y git wget

adduser tadpole --disabled-password --disabled-login --gecos ""
deluser tadpole wheel # wheel group is default and has sudo rights on Research CLoud machine
su tadpole -c "bash setup_jupyter.sh $1"
PYTHON_COMMAND="from notebook.auth import passwd; print(passwd(\"$1\"))"
export HASHED_PASSWORD=`su tadpole -c "~/miniconda3/envs/tadpole/bin/python3 -c '${PYTHON_COMMAND}'"`
mkdir /home/tadpole/.jupyter
envsubst < jupyter_notebook_config.py > /home/tadpole/.jupyter/jupyter_notebook_config.py
chown -R tadpole:tadpole /home/tadpole/.jupyter

cp start.sh /usr/bin/start-lab.sh
chmod 755 /usr/bin/start-lab.sh
cp lab.service /etc/systemd/system/
chmod 644 /etc/systemd/system/lab.service
