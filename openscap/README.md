# How To Run OpenSCAP (OSCAP) on Centos

This project creates a Centos server that passes 100% of Lynis tests. This document shows how to run `openscap` on that server.

I am exploring how to create a Fedora CoreOS server that can pass as many security checks as possible. However, I am not a security guru. Make sure to vet anything you read here with your own experts.

This work is being done at the request of the Enterprise Container Working Group (ECWG) of the Office of Information and Technology (OIT - https://www.oit.va.gov/) at the Department of Veteran Affairs.

## Goal

Run `oscap` on Centos.

## Definitions

Security Content Automation Protocol (SCAP) is U.S. standard maintained by National Institute of Standards and Technology (NIST).

OpenSCAP (https://www.open-scap.org/) is an ecosystem providing multiple tools to assist administrators and auditors with assessment, measurement, and enforcement of security baselines.

## Installation

The first step is to install the software.

```bash
sudo yum install -y openscap openscap-scanner scap-security-guide unzip
```

You can list the installed files using this command.

```bash
rpm -ql openscap
```

## Using SSG

When `scap-security-guide` was installed, it added many files to your system. We care about just one. That one is `ssg-centos7-xccdf.xml`.

Look at its profiles.

```bash
oscap info /usr/share/xml/scap/ssg/content/ssg-centos7-xccdf.xml
Profiles:
	Title: PCI-DSS v3.2.1 Control Baseline for Red Hat Enterprise Linux 7
		Id: pci-dss
	Title: Standard System Security Profile for Red Hat Enterprise Linux 7
		Id: standard
```

Run the evaluation.

```bash
sudo oscap xccdf eval \
		--fetch-remote-resources \
    --profile standard \
    --report centos7-report.html \
    --results centos7-results.xml \
    /usr/share/xml/scap/ssg/content/ssg-centos7-xccdf.xml
```

Generate fixes.

```bash
sudo oscap xccdf generate fix --fetch-remote-resources --fix-type ansible --profile standard --output playbook-centos7-fixes.yml /usr/share/xml/scap/ssg/content/ssg-centos7-xccdf.xml
```

## Fetch STIG

### Manually

* Manual fetch
	* Visit https://public.cyber.mil/stigs/downloads/.
	* Search `Red Hat` in the search next to list, not at the top of the page.
	* Download a `Red Hat Enterprise Linux 7 STIG - Ver 2, Rel 7`.

### Automated

* SSH to server. You'll be in the `/home/centos` directory.

* Curl fetch

```
curl -O https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_RHEL_7_V2R7_STIG.zip
curl -O https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_RHEL_7_V2R3_STIG_Ansible.zip
```

* Unzip file

```
unzip U_RHEL_7_V2R7_STIG.zip
unzip U_RHEL_7_V2R3_STIG_Ansible.zip
mkdir ansible
pushd ansible
unzip ../rhel7STIG-ansible.zip
popd
```

## Review Profiles

```bash
oscap info /home/centos/U_RHEL_7_V2R7_Manual_STIG/U_RHEL_7_STIG_V2R7_Manual-xccdf.xml | more

Profiles:
	Title: I - Mission Critical Classified
		Id: MAC-1_Classified
	Title: I - Mission Critical Public
		Id: MAC-1_Public
	Title: I - Mission Critical Sensitive
		Id: MAC-1_Sensitive
	Title: II - Mission Support Classified
		Id: MAC-2_Classified
	Title: II - Mission Support Public
		Id: MAC-2_Public
	Title: II - Mission Support Sensitive
		Id: MAC-2_Sensitive
	Title: III - Administrative Classified
		Id: MAC-3_Classified
	Title: III - Administrative Public
		Id: MAC-3_Public
	Title: III - Administrative Sensitive
		Id: MAC-3_Sensitive
```

We'll used the `MAC-1_Classified` profile.

## Run Evaluation

The DISA files are not too useful. They don't check anything.

```bash
sudo oscap xccdf eval \
		--fetch-remote-resources \
    --profile MAC-1_Classified \
    --report rhel7-report.html \
    --results rhel7-results.xml \
    /home/centos/U_RHEL_7_V2R7_Manual_STIG/U_RHEL_7_STIG_V2R7_Manual-xccdf.xml
```

## Generate Fix

The DISA files are not too useful. They run just a few checks.

```bash
oscap xccdf generate fix \
		--fetch-remote-resources \
		--fix-type ansible \
		--profile MAC-1_Classified \
		--output playbook-rhel7-fixes.yml \
		/home/centos/U_RHEL_7_V2R7_Manual_STIG/U_RHEL_7_STIG_V2R7_Manual-xccdf.xml
```

After the evaluation is complete, look at rhel7-report.html.

## Remediate

Note that I have not done this. Proceed with caution.

```
oscap xccdf eval --remediate --profile stig-rhel7-disa --results scan-sccdf-results.xml /usr/share/xml/scap/ssg/content/ssg-rhel7-ds.xml
```

## OVAL

I don't understand much about OVAL yet.

```
sudo oscap oval eval \
  --results oval-results.xml \
   --report report.html \
    /usr/share/xml/scap/ssg/content/ssg-fedora-oval.xml

oscap xccdf export-oval-variables \
    --profile united_states_government_configuration_baseline \
    usgcb-rhel5desktop-xccdf.xml
```

## Research

* https://vuls.io/
* https://www.openvas.org/
* SCAP
	* https://oteemo.com/2018/03/21/stig-scap-aws-ansible-oh-my/
	* https://fatmin.com/2019/07/25/openscap-part-3-running-scans-from-the-command-line-in-rhel-7/
	* https://github.com/openprivacy/ansible-scap
* SPEL - STIG-Compliant Enterprise Linux
	* https://github.com/ferricoxide/spel
	* https://github.com/plus3it/spel
* Ansible Scripts
	* https://github.com/samdoran/ansible-role-rhel7-stig
	* https://github.com/MindPointGroup/RHEL7-STIG
	* https://github.com/ansible/ansible-lockdown
	* https://clasohm.com/wp/2016/08/16/linux-security-hardening-with-openscap-and-ansible/ - old, how to use mindpoint group playbook.
* Remediation
	* http://blog.siphos.be/2013/12/remediation-through-scap/
