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

provisioner "file" {
    # локальное расположение скрипта
    source = "/home/filareth/hillel/scripts/script01.sh"

    # где должен располагаться скрипт на поднятой машине
    destination = "/tmp/script01.sh"

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
        "chmod +x /tmp/script01.sh",
        "sudo /tmp/script01.sh args",
      ] 
      
    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }

provisioner "file" {
    source = "/home/filareth/hillel/scripts/default.conf"
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
    source = "/home/filareth/hillel/scripts/php-fpm.conf"
    destination = "/etc/nginx/conf.d/php-fpm.conf"

    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }

  provisioner "file" {
    source = "/home/filareth/hillel/scripts/www.conf"
    destination = "/etc/php-fpm.d/www.conf"

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
    destination = "/usr/share/nginx/html/index.php"

    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }

provisioner "file" {
    # локальное расположение скрипта
    source = "/home/filareth/hillel/scripts/script02.sh"

    # где должен располагаться скрипт на поднятой машине
    destination = "/tmp/script02.sh"

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
        "chmod +x /tmp/script02.sh",
        "sudo /tmp/script02.sh args",
      ] 
      
    connection {    
      type = "ssh"
      user  = "centos"
      host = self.public_ip      
      agent = true
      timeout  = "5m"      
      }
  }

}