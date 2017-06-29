#!/bin/bash -eux
# enable tty console
sed -i 's#quiet#quiet console=ttyS0#' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

# remove ip and mac address
rm -fr /etc/udev/rules.d/70-persistent-net.rules
rm -fr /etc/sysconfig/network-scripts/ifcfg-eth0