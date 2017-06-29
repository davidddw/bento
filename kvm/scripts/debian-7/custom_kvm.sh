#!/bin/bash -eux
# add custom script in here

# enable tty console
PATH=/sbin:/usr/sbin:/bin:/usr/bin
sed -i -e 's#GRUB_CMDLINE_LINUX=.*$#GRUB_CMDLINE_LINUX="text console=tty0 console=ttyS0,115200n8"#' \
-e 's/#GRUB_TERMINAL=console/GRUB_TERMINAL=console/' \
-e 's#GRUB_CMDLINE_LINUX_DEFAULT="quiet"#GRUB_CMDLINE_LINUX_DEFAULT=""#' /etc/default/grub
update-grub
sed -i 's@#T0.*@T0:23:respawn:/sbin/getty -L ttyS0 115200 vt100@' /etc/inittab

# delete nic config
sed -i '/eth0/,$d' /etc/network/interfaces