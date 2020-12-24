#!/bin/bash

HOMEDIR=/home/vagrant

VERSION=$(<${HOMEDIR}/.vbox_version)
ISO="VBoxGuestAdditions_${VERSION}.iso";

apt update;
apt install -y build-essential dkms bzip2 tar linux-headers-`uname -r`

mkdir -p /tmp/vbox;
mount -o loop $HOMEDIR/$ISO /tmp/vbox;

echo "installing the vbox additions"
/tmp/vbox/VBoxLinuxAdditions.run --nox11 || true

umount /tmp/vbox;
rm -rf /tmp/vbox;
rm -f $HOMEDIR/*.iso $HOMEDIR/.vbox_version;

apt remove -y build-essential gcc g++ make libc6-dev dkms \
    linux-headers-`uname -r`

echo "removing leftover logs"
rm -rf /var/log/vboxadd*
