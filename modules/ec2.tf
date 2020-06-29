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

############################################################################
# INSTANCE
############################################################################
resource "aws_instance" "centos7" {
  ami 			= data.aws_ami.centos7.id
  instance_type = "t2.micro"
  key_name      = "key_centos"
  
  vpc_security_group_ids = ["aws_security_group.allow_ssh.id"]

  tags = {
    Name = "Centos7 Nginx PHP"
  }
}