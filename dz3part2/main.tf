data "aws_ami" "centos7" {
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

resource "aws_instance" "web" {
  ami           = data.aws_ami.centos7.id
  instance_type = var.instance_type
  key_name      = "key_centos7"

  tags = {
    name        = terraform.workspace
  }  
}

