## Default route to Internet
# создаем маршрут по умолчанию в таблице маршрутизации
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.HillelVPC.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gateway.id}"
}

## Routing table
# создаем внутреннюю таблицу маршрутизации и маршруты для приватной  сети
resource "aws_route_table" "private_route_table" {
    vpc_id   = "${aws_vpc.HillelVPC.id}"

    tags = {
        Name = "Private route table"
    }
}

resource "aws_route" "private_route" {
    route_table_id  = "${aws_route_table.private_route_table.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
}

# создаем внутреннюю таблицу маршрутизации и маршруты для публичной сети
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.HillelVPC.id}"
  tags = {
      Name = "Public route table"
  }
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gateway.id}"
    }
}

## Route tables associations
# делаем привязку подсетей и таблиц маршрутизации
# Associate subnet public_subnet to public route table
resource "aws_route_table_association" "public_subnet_association" {
    subnet_id = "${aws_subnet.aws-subnet-public.id}"
    route_table_id = "${aws_vpc.HillelVPC.main_route_table_id}"
}

# Associate subnet private_subnet to private route table
resource "aws_route_table_association" "private_subnet_association" {
    subnet_id = "${aws_subnet.aws-subnet-private.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}