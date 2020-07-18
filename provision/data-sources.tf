data "aws_ami" "distro" {
  owners      = ["679593333241"]
  most_recent = true
  filter {
      name   = "name"
      values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }
  filter {
      name   = "architecture"
      values = ["x86_64"]
  }
  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}

# data "aws_ami" "distro" {
#   most_recent = true

#   filter {
#     name = "name"

#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server*"]
#   }

#   filter {
#     name = "virtualization-type"

#     values = ["hvm"]
#   }

#   owners = ["099720109477"]
# }

data "template_file" "tf_ansible_vars_file" {
    template = "${file("./tr_ansible_vars_file.yml.tpl")}"
    vars = {
        ansible_python_interpreter = var.ansible_python_interpreter
        banner_text_file = var.banner_text_file
        centos_user_password = random_password.centos_user_password.result
        password_max_days = var.password_max_days
        password_min_days = var.password_min_days
        timestamp = "${timestamp()}"
        sha_crypt_max_rounds = var.sha_crypt_max_rounds
        sha_crypt_min_rounds = var.sha_crypt_min_rounds
        ssh_user = var.ssh_user
    }
}
