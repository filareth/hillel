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

resource "aws_security_group" "allow_ssh" {
  name        = "port 22"
  description = "Allow ssh inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "port 22"
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.centos7.id
  instance_type = var.aws-ec2-type
  key_name      = var.aws-key-name
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

ebs_block_device {
device_name = "/dev/sdc"
volume_size = 1
volume_type = "gp2"
}

ebs_block_device {
device_name = "/dev/sdd"
volume_size = 1
volume_type = "gp2"
}

ebs_block_device {
device_name = "/dev/sde"
volume_size = 1
volume_type = "gp2"
}

  tags = {
    Name        = terraform.workspace
  }  
}

