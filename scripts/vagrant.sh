#!/bin/bash

HOMEDIR=/home/vagrant
AUTHORIZEDKEYS=${HOMEDIR}/.ssh/authorized_keys
VAGRANTPUBKEY="https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub"

mkdir -p ${HOMEDIR}/.ssh

wget --no-check-certificate "$VAGRANTPUBKEY" -O ${AUTHORIZEDKEYS}

chown -R vagrant. ${AUTHORIZEDKEYS%/*}
chmod -R go-srwx ${AUTHORIZEDKEYS}
