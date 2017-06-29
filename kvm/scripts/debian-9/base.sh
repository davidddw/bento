#!/bin/bash -eux
# Only add the secure path line if it is not already present - Debian 7
# includes it by default.

cat <<'EOF' > /etc/apt/sources.list
deb http://ftp.cn.debian.org/debian/ stretch main contrib non-free
deb-src http://ftp.cn.debian.org/debian/ stretch main contrib non-free
deb http://ftp.cn.debian.org/debian-security/ stretch/updates main
deb-src http://ftp.cn.debian.org/debian-security/ stretch/updates main
EOF
apt-get update
apt-get install -y libglib2.0-0 curl

# Disable automatic udev rules for network interfaces in Ubuntu,
# source: http://6.ptmc.org/164/
rm -f /etc/udev/rules.d/70-persistent-net.rules;
mkdir -p /etc/udev/rules.d/70-persistent-net.rules;
rm -f /lib/udev/rules.d/75-persistent-net-generator.rules;
rm -rf /dev/.udev/ /var/lib/dhcp/*;

# Adding a 2 sec delay to the interface up, to make the dhclient happy
echo "pre-up sleep 2" >> /etc/network/interfaces

cat <<'EOF' > /home/packer/.bashrc
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
force_color_prompt=yes
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
export EDITOR=vim
export VISUAL=vim
EOF
