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
# SECURITY GROUP
############################################################################
resource "aws_security_group" "allow_ssh_http_https" {
  name        = "ssh, http, https"
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
# INSTANCE
############################################################################
resource "aws_instance" "centos7" {
  ami           = data.aws_ami.centos7.id
  instance_type = "t2.micro"
  key_name      = "key_centos"
  subnet_id     = "$var.aws-subnet-public-A}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_http_https.id}"]

  tags = {
    Name = "Centos full"
  }
}