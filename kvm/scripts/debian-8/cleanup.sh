#!/bin/bash -eux
echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*
: > /etc/apt/sources.list
apt-get clean