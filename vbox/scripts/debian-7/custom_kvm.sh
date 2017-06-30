#!/bin/bash -eux
# add custom script in here

# delete nic config
sed -i '/eth0/,$d' /etc/network/interfaces