resource "aws_vpc" "HillelVPC" {
    cidr_block           = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name        = "Hillel-VPC"
    }
}

## Public subnet
resource "aws_subnet" "aws-subnet-public-A" {
  vpc_id            = "${aws_vpc.HillelVPC.id}"
  cidr_block        = "${var.vpc_cidr_public_subnet_A}"
  tags = {
    Name            = "Public subnet-A"
  }
}

resource "aws_subnet" "aws-subnet-public-B" {
  vpc_id            = "${aws_vpc.HillelVPC.id}"
  cidr_block        = "${var.vpc_cidr_public_subnet_B}"
  tags = {
    Name            = "Public subnet-B"
  }
}

## Private subnet
resource "aws_subnet" "aws-subnet-private-A" {
  vpc_id            = "${aws_vpc.HillelVPC.id}"
  cidr_block        = "${var.vpc_cidr_private_subnet_A}"
  tags = {
    Name            = "Private subnet-A"
  }
}

resource "aws_subnet" "aws-subnet-private-B" {
  vpc_id            = "${aws_vpc.HillelVPC.id}"
  cidr_block        = "${var.vpc_cidr_private_subnet_B}"
  tags = {
    Name            = "Private subnet-B"
  }
}

## Internet gateway
# создает тот самый виртуальный шлюз в интернет внутри VPC
resource "aws_internet_gateway" "gateway" {
    vpc_id = "${aws_vpc.HillelVPC.id}"
}

## Elastic IP for NAT GW
# резервирует статический внешний IP адрес, чтоб наши сервера выходили в интернет всегда с одного адреса
resource "aws_eip" "eip1" {
  vpc        = true
  depends_on = ["aws_internet_gateway.gateway"]
}

resource "aws_eip" "eip2" {
  vpc        = true
  depends_on = ["aws_internet_gateway.gateway"]
}

## NAT gateway
# создает NAT шлюз, который будет NAT'ить исходящие соединения (идет привязка к публичной подсети и внешнему IP, он будет создан только после интернет шлюза
resource "aws_nat_gateway" "nat_a" {
    allocation_id = "${aws_eip.eip1.id}"
    subnet_id     = "${aws_subnet.aws-subnet-public-A.id}"
    depends_on    = ["aws_internet_gateway.gateway"]
    tags = {
      Name            = "NAT-A"
    }
}

resource "aws_nat_gateway" "nat_b" {
    allocation_id = "${aws_eip.eip2.id}"
    subnet_id     = "${aws_subnet.aws-subnet-public-B.id}"
    depends_on    = ["aws_internet_gateway.gateway"]
    tags = {
      Name            = "NAT-B"
    }
}
