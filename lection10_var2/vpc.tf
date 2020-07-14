resource "aws_vpc" "HillelVPC" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true
    tags = {
        Name             = "Hillel-VPC"
    }
}

## Public subnet
resource "aws_subnet" "aws-subnet-public" {
  vpc_id                 = aws_vpc.HillelVPC.id
  cidr_block             = var.public_subnet
  tags = {
    Name                 = "Public subnet"
  }
}

## Private subnet
resource "aws_subnet" "aws-subnet-private" {
  vpc_id                 = aws_vpc.HillelVPC.id
  cidr_block             = var.private_subnet
  tags = {
    Name                 = "Private subnet"
  }
}

## Internet gateway
# создает тот самый виртуальный шлюз в интернет внутри VPC
resource "aws_internet_gateway" "gateway" {
    vpc_id              = aws_vpc.HillelVPC.id
}

## Elastic IP for NAT GW
# резервирует статический внешний IP адрес, чтоб наши сервера выходили в интернет всегда с одного адреса
resource "aws_eip" "eip" {
  vpc                   = true
  #depends_on           = ["aws_internet_gateway.gateway"]
}

## NAT gateway
# создает NAT шлюз, который будет NAT'ить исходящие соединения (идет привязка к публичной подсети и внешнему IP, он будет создан только после интернет шлюза
resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.eip.id
    subnet_id           = aws_subnet.aws-subnet-public.id
    #depends_on         = ["aws_internet_gateway.gateway"]
    tags = {
      Name              = "NAT"
    }
}