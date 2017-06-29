#!/bin/bash -eux
# add custom script in here

# remove ip and mac address
rm -fr /etc/udev/rules.d/70-persistent-net.rules
rm -fr /etc/sysconfig/network/ifcfg-eth0

# enable tty console
PATH=/sbin:/usr/sbin:/bin:/usr/bin
sed -i -e 's#GRUB_CMDLINE_LINUX=""#GRUB_CMDLINE_LINUX="console=ttyS0 console=ttyS0,115200n8"#' \
-e 's#splash=silent quiet##' /etc/default/grub
/sbin/update-bootloader --refresh
