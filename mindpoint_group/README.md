# MindPoint Group

```bash
cd /data/projects
git clone https://github.com/MindPointGroup/RHEL7-STIG.git
cd /data/projects/RHEL7-STIG

```

* Make sure to have jmespath installed on your local workstation.

```bash
pip install jmespath
```

cat <<EOF > inventory
[all]
54.237.107.49
EOF

cat <<EOF > playbook.david.yml
---
- name: Apply STIG
  hosts: all
  become: yes
  roles:
    - role: "{{ playbook_dir }}"
EOF


```
cat <<EOF > run-david-playbook.sh
#!/bin/bash

python3 \
  $(which ansible-playbook) \
  -i inventory \
  -u centos \
  playbook.david.yml
EOF
```