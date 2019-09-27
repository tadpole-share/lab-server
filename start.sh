#!/bin/bash
jupyter lab &
ssh -R tadpole:443:localhost:8888 tadpole@serveo.net