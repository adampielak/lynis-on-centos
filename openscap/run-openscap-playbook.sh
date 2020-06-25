#!/bin/bash

rm -rf /tmp/fetched/*

python3 \
  $(which ansible-playbook) \
  -i ../inventory \
  -u centos \
  playbook.openscap.yml

LATEST_PLAYBOOK=$(find /tmp/fetched -name playbook-centos7-fixes.yml -type f | xargs ls -ltr | tail -n 1 | awk '{print $NF}')
cp $LATEST_PLAYBOOK ./playbook-centos7-fixes.yml

LATEST_REPORT=$(find /tmp/fetched -name centos7-report.html -type f | xargs ls -ltr | tail -n 1 | awk '{print $NF}')
if [ ! -z $LATEST_REPORT ]; then
  cp $LATEST_REPORT ./centos7-report.html
  xdg-open ./centos7-report.html
fi
