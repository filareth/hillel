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
resource "aws_security_group" "allow_ssh" {
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
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  tags = {
    Name = "Centos"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/17"
}


resource "aws_subnet" "sub01" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.0.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 0)}"
  tags = {
    Name = "01"
  }
}

resource "aws_subnet" "sub02" {
  vpc_id     = "${aws_vpc.main.id}"

  # 10.10.8.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 1)}"
  tags = {
    Name = "02"
  }
}

resource "aws_subnet" "sub03" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.16.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 2)}"
  tags = {
    Name = "03"
  }
}

resource "aws_subnet" "sub04" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.24.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 3)}"
  tags = {
    Name = "04"
  }
}

resource "aws_subnet" "sub05" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.32.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 4)}"
  tags = {
    Name = "05"
  }
}

resource "aws_subnet" "sub06" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.40.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 5)}"
  tags = {
    Name = "06"
  }
}

resource "aws_subnet" "sub07" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.48.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 6)}"
  tags = {
    Name = "07"
  }
}

resource "aws_subnet" "sub08" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.56.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 7)}"
  tags = {
    Name = "08"
  }
}

resource "aws_subnet" "sub09" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.64.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 8)}"
  tags = {
    Name = "09"
  }
}

resource "aws_subnet" "sub10" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.72.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 9)}"
  tags = {
    Name = "10"
  }
}

resource "aws_subnet" "sub11" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.80.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 10)}"
  tags = {
    Name = "11"
  }
}

resource "aws_subnet" "sub12" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.88.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 11)}"
  tags = {
    Name = "12"
  }
}

resource "aws_subnet" "sub13" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.96.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 12)}"
  tags = {
    Name = "13"
  }
}

resource "aws_subnet" "sub14" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.104.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 13)}"
  tags = {
    Name = "14"
  }
}

resource "aws_subnet" "sub15" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.112.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 14)}"
  tags = {
    Name = "15"
  }
}

resource "aws_subnet" "sub16" {
  vpc_id     = "${aws_vpc.main.id}"
  # 10.10.120.0/21
  cidr_block = "${cidrsubnet("10.10.0.0/17", 4, 15)}"
  tags = {
    Name = "16"
  }
}