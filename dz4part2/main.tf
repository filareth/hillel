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
# ПАРАМЕТРЫ БЕЗОПАСНОСТИ
############################################################################

resource "aws_security_group" "allow_ssh_default" {
  name        = "allow_ssh_default"
  description = "Allow ssh inbound traffic"

 # Разрешить входящие SSH
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешить все исходящие
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_default"
  }
}

############################################################################
# ИНСТАНС
############################################################################

resource "aws_instance" "default" {
  ami           = data.aws_ami.centos7.id
  instance_type = var.aws-ec2-type
  key_name      = var.aws-key-name
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_default.id}"]

  tags = {
    Name        = terraform.workspace
  }  

# подключаемые диски
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

provisioner "file" {
    # локальное расположение скрипта
    source = "/home/filareth/hillel/lection4/dz4part2/script.sh"

    # где должен располагаться скрипт на поднятой машине
    destination = "/tmp/script.sh"

    connection {    
      type = "ssh"
      user  = "centos"
      #private_key = "/home/filareth/.ssh/key_centos.pem"
      host = self.public_ip      
      agent = true
      timeout  = "3m"      
      }
  }


# выполнение на поднятом инстансе
provisioner "remote-exec" {
    inline = [
        "ssh-add /home/filareth/.ssh/key_centos.pem",
        "chmod +x /tmp/script.sh",
        "sudo /tmp/script.sh args",
      ] 
      
    connection {    
      type = "ssh"
      user  = "centos"
      #private_key = "/home/filareth/.ssh/key_centos.pem"
      host = self.public_ip      
      agent = true
      timeout  = "3m"      
      }
  }

}
