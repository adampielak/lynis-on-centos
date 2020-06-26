#!/bin/bash

SSH_USER=$1
IP_ADDRESS=$2
PKI_PRIVATE_KEY=$3

export ANSIBLE_HOST_KEY_CHECKING=false

python3 \
  $(which ansible-playbook) \
  -i "$IP_ADDRESS," \
  --private-key $PKI_PRIVATE_KEY
  -u $SSH_USER \
  playbook.setup.yml
