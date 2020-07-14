data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

############################################################################
# SECURITY GROUP
############################################################################
resource "aws_security_group" "allow_ssh" {
  name        = "ssh"
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
    Name = "ssh"
  }
}



############################################################################
# INSTANCE
############################################################################
resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.centos7.id
  instance_type = "t2.micro"
  key_name      = "key_centos"
  subnet_id     = "${aws_subnet.aws-subnet-private.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  tags = {
    Name = "Ubuntu"
  }
}