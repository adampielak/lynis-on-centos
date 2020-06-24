#!/bin/bash

python3 \
  $(which ansible-playbook) \
  -i inventory \
  -u centos \
  playbook.in-process.yml
