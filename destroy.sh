#!/bin/bash
systemctl stop lab
sleep 10
deluser tadpole
rm -rf /home/tadpole
rm /usr/bin/start-lab.sh
rm /etc/systemd/system/lab.service