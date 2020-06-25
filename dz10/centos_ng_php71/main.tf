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

resource "aws_security_group" "allow_ssh" {
  name        = "ssh, http, https"
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

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
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
    Name = "ssh, http, https"
  }
}

############################################################################
# ИНСТАНС
############################################################################

resource "aws_instance" "default" {
  ami           = data.aws_ami.centos7.id
  instance_type = var.aws-ec2-type
  key_name      = var.aws-key-name
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  tags = {
    Name        = "Centos Nginx php"
  }  

# ----------------------------- copy script dz10.sh ------
provisioner "file" {
    # локальное расположение скрипта
    source = "/home/filareth/hillel/scripts/dz10.sh"

    # где должен располагаться скрипт на поднятой машине
    destination = "/tmp/dz10.sh"

    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }

# выполнение на поднятом инстансе
provisioner "remote-exec" {
    inline = [
        "ssh-add /home/filareth/.ssh/key_centos.pem",
        "chmod +x /tmp/dz10.sh",
        "sudo /tmp/dz10.sh args",
      ] 
      
    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }
# -------------------------------------------------------------

  provisioner "file" {
    source = "/home/filareth/hillel/scripts/nginx.repo"
    destination = "/etc/yum.repos.d/nginx.repo"

    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  } 

# --------------------------- copy script dz10_1.sh ------
provisioner "file" {
    # локальное расположение скрипта
    source = "/home/filareth/hillel/scripts/dz10_1.sh"

    # где должен располагаться скрипт на поднятой машине
    destination = "/tmp/dz10_1.sh"

    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }

# выполнение на поднятом инстансе
provisioner "remote-exec" {
    inline = [
        "ssh-add /home/filareth/.ssh/key_centos.pem",
        "chmod +x /tmp/dz10_1.sh",
        "sudo /tmp/dz10_1.sh args",
      ] 
      
    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }
# -------------------------------------------------------------
provisioner "file" {
    source = "/home/filareth/hillel/distr_original/centos_ng_php71/default.conf"
    destination = "/etc/nginx/conf.d/default.conf"

    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }

  provisioner "file" {
    source = "/home/filareth/hillel/scripts/index.php"
    destination = "/var/www/example.com/index.php"

    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }

# --------------------------- copy script dz10_2.sh ------
provisioner "file" {
    # локальное расположение скрипта
    source = "/home/filareth/hillel/scripts/dz10_2.sh"

    # где должен располагаться скрипт на поднятой машине
    destination = "/tmp/dz10_2.sh"

    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }

# выполнение на поднятом инстансе
provisioner "remote-exec" {
    inline = [
        "ssh-add /home/filareth/.ssh/key_centos.pem",
        "chmod +x /tmp/dz10_2.sh",
        "sudo /tmp/dz10_2.sh args",
      ] 
      
    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }
# -------------------------------------------------------------
}



