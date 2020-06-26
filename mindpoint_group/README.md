# MindPoint Group

```bash
cd /data/projects
git clone https://github.com/MindPointGroup/RHEL7-STIG.git
cd RHEL7-STIG

```

* Make sure to have jmespath installed on your local workstation.

```bash
pip install jmespath
```

My first run added a password requirement for sudo but the `centos` user does not have a password.

/etc/sudoers
/etc/sudoers.d/90-cloud-init-users



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