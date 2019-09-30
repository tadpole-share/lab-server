#!/bin/bash
. ~/miniconda3/etc/profile.d/conda.sh
conda activate tadpole
ssh -o "StrictHostKeyChecking no" -R tadpole:443:localhost:8888 tadpole@serveo.net &
cd jupyter
jupyter lab
