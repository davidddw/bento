#!/bin/bash -eux

# add custom script in here

# remove ip and mac address
rm -fr /etc/udev/rules.d/70-persistent-net.rules
rm -fr /etc/sysconfig/network/ifcfg-eth0

# enable tty console
PATH=/sbin:/usr/sbin:/bin:/usr/bin
sed -i 's@#S0.*@S0:12345:respawn:/sbin/agetty -L 9600 ttyS0 vt102@' /etc/inittab
echo "ttyS0" >> /etc/securetty