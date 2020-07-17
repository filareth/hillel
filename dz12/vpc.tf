data "aws_ami" "centos7" {
owners       = ["679593333241"]
most_recent  = true

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
# CREATE VPC
############################################################################
resource "aws_vpc" "HillelVPC" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true
    tags = {
        Name             = "Hillel-VPC"
    }
}

############################################################################
# CREATE Internet gateway
############################################################################
# создает тот самый виртуальный шлюз в интернет внутри VPC
resource "aws_internet_gateway" "igw" {
    vpc_id              = aws_vpc.HillelVPC.id
    tags = {
      Name              = "IGW Hillel"
    }
}

############################################################################
# SECURITY GROUP
############################################################################
resource "aws_security_group" "nat" {
  name          = "vpc_nat"
  description   = "Allow ssh inbound traffic"
  vpc_id        = aws_vpc.HillelVPC.id

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
    Name = "NAT SG"
  }
}

############################################################################
# CREATE EIP
############################################################################
# резервирует статический внешний IP адрес, чтоб наши сервера выходили в интернет всегда с одного адреса
resource "aws_eip" "nat" {
  instance      = aws_instance.nat.id
  vpc           = true
 
}

# -----------------
#   Public subnet
# -----------------
resource "aws_subnet" "test-public" {
  vpc_id                 = aws_vpc.HillelVPC.id

  cidr_block             = var.public_subnet
  availability_zone      = "us-east-1a"

  tags = {
    Name                 = "Public subnet"
  }
}

resource "aws_route_table" "test-public" {
  vpc_id                = aws_vpc.HillelVPC.id

  route {
        cidr_block      = "0.0.0.0/0"
        gateway_id      = aws_internet_gateway.igw.id
    }

  tags = {
      Name              = "Public subnet"
  }
}

resource "aws_route_table_association" "test-public" {
    subnet_id           = aws_subnet.test-public.id
    route_table_id      = aws_route_table.test-public.id
}
# -----------------
#  Private subnet
# -----------------

resource "aws_subnet" "test-private" {
  vpc_id                 = aws_vpc.HillelVPC.id

  cidr_block             = var.private_subnet
  availability_zone      = "us-east-1a"

  tags = {
    Name                 = "Private subnet"
  }
}

resource "aws_route_table" "test-private" {
    vpc_id              = aws_vpc.HillelVPC.id

    route {
      cidr_block        = "0.0.0.0/0"
      instance_id       = aws_instance.nat.id
    }

    tags = {
        Name            = "Private subnet"
    }
}

# ------------------------------------------
#  Привязка подсетей и таблиц маршрутизации
# ------------------------------------------

resource "aws_route_table_association" "test-private" {
    subnet_id           = aws_subnet.test-private.id
    route_table_id      = aws_route_table.test-private.id
}

############################################################################
# NAT gateway
############################################################################
# создает NAT шлюз, который будет NAT'ить исходящие соединения (идет привязка к публичной подсети и внешнему IP, он будет создан только после интернет шлюза

resource "aws_instance" "nat" {
  ami                    = data.aws_ami.centos7.id
  availability_zone      = "us-east-1a"
  instance_type          = "t2.micro"
  key_name               = "key_centos"
  subnet_id              = aws_subnet.test-public.id
  vpc_security_group_ids = ["${aws_security_group.nat.id}"]
  associate_public_ip_address = true
  source_dest_check           = false

  tags = {
    Name                 = "Centos VPC NAT"
  }
}
