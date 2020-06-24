#!/bin/bash

python3 \
  $(which ansible-playbook) \
  -i inventory \
  -u centos \
  playbook.harden-to-100.yml
