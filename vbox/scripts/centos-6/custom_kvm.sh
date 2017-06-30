#!/bin/bash -eux
# add custom script in here

# remove ip and mac address
rm -fr /etc/udev/rules.d/70-persistent-net.rules
sed -i '/HWADDR=.*/d' /etc/sysconfig/network-scripts/ifcfg-eth0