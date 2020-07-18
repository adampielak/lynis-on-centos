variable "aws_profile" {
  default = "ic1"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "pki_private_key" {
  default = "/home/medined/Downloads/pem/david-va-oit-cloud-k8s.pem"
}

variable "pki_public_key" {
  default = "/home/medined/Downloads/pem/david-va-oit-cloud-k8s.pub"
}

variable "ssh_cidr_block" {
  default = "0.0.0.0/0"
}

# The ssh_user variable is used by both Terraform and Ansible.
variable "ssh_user" {
  default = "centos"
}

variable "subnet_id" {
  default = "subnet-02c78f939d58e2320"
}

variable "vpc_id" {
  default = "vpc-04bdc9b68b19472c3"
}

# Ansible Variables
#
# Terraform is the driving process. Therefore all variables 
# will be defined here and pushed over to Ansible using a template.
#
# This should be simpler than having two sets of variables.
#
# ....###....##....##..######..####.########..##.......########
# ...##.##...###...##.##....##..##..##.....##.##.......##......
# ..##...##..####..##.##........##..##.....##.##.......##......
# .##.....##.##.##.##..######...##..########..##.......######..
# .#########.##..####.......##..##..##.....##.##.......##......
# .##.....##.##...###.##....##..##..##.....##.##.......##......
# .##.....##.##....##..######..####.########..########.########


# .##.....##....###....########..####....###....########..##.......########..######.
# .##.....##...##.##...##.....##..##....##.##...##.....##.##.......##.......##....##
# .##.....##..##...##..##.....##..##...##...##..##.....##.##.......##.......##......
# .##.....##.##.....##.########...##..##.....##.########..##.......######....######.
# ..##...##..#########.##...##....##..#########.##.....##.##.......##.............##
# ...##.##...##.....##.##....##...##..##.....##.##.....##.##.......##.......##....##
# ....###....##.....##.##.....##.####.##.....##.########..########.########..######.
#

variable "ansible_python_interpreter" {
  default = "/bin/python3"
}

variable "banner_text_file" {
  default = "file-banner-text.txt"
}

variable "password_max_days" {
  default = "90"
}

variable "password_min_days" {
  default = "1"
}

variable "sha_crypt_max_rounds" {
  default = "10000"
}

variable "sha_crypt_min_rounds" {
  default = "5000"
}
