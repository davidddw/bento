# Only add the secure path line if it is not already present - Debian 7
# includes it by default.
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers;
sed -i -e 's/%sudo\s*ALL=(ALL:ALL) ALL/%sudo\tALL=(ALL) NOPASSWD:ALL/g' /etc/sudoers;

cat <<'EOF' > /etc/apt/sources.list
deb http://cn.archive.ubuntu.com/ubuntu/ wily main restricted universe multiverse
deb http://cn.archive.ubuntu.com/ubuntu/ wily-security main restricted universe multiverse
deb http://cn.archive.ubuntu.com/ubuntu/ wily-updates main restricted universe multiverse
deb http://cn.archive.ubuntu.com/ubuntu/ wily-proposed main restricted universe multiverse
deb http://cn.archive.ubuntu.com/ubuntu/ wily-backports main restricted universe multiverse
deb-src http://cn.archive.ubuntu.com/ubuntu/ wily main restricted universe multiverse
deb-src http://cn.archive.ubuntu.com/ubuntu/ wily-security main restricted universe multiverse
deb-src http://cn.archive.ubuntu.com/ubuntu/ wily-updates main restricted universe multiverse
deb-src http://cn.archive.ubuntu.com/ubuntu/ wily-proposed main restricted universe multiverse
deb-src http://cn.archive.ubuntu.com/ubuntu/ wily-backports main restricted universe multiverse
EOF

apt-get update
apt-get install -y --force-yes libglib2.0-0 curl python

echo "UseDNS no" >> /etc/ssh/sshd_config
sed -i "s/nameserver .*/nameserver 8.8.8.8/" /etc/resolv.conf
