## Default route to Internet
# создаем маршрут по умолчанию в таблице маршрутизации
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.HillelVPC.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gateway.id}"
}

## Routing table
# создаем внутреннюю таблицу маршрутизации и маршруты для приватной  сети
resource "aws_route_table" "private_route_table_A" {
    vpc_id   = "${aws_vpc.HillelVPC.id}"

    tags = {
        Name = "Private route table"
    }
}

resource "aws_route" "private_route_A" {
    route_table_id  = "${aws_route_table.private_route_table_A.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_a.id}"
}
 #------------------------------------------------------
resource "aws_route_table" "private_route_table_B" {
    vpc_id   = "${aws_vpc.HillelVPC.id}"

    tags = {
        Name = "Private route table"
    }
}

resource "aws_route" "private_route_B" {
    route_table_id  = "${aws_route_table.private_route_table_B.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_b.id}"
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
resource "aws_route_table_association" "public_subnet_association_A" {
    subnet_id = "${aws_subnet.aws-subnet-public-A.id}"
    route_table_id = "${aws_vpc.HillelVPC.main_route_table_id}"
}

resource "aws_route_table_association" "public_subnet_association_B" {
    subnet_id = "${aws_subnet.aws-subnet-public-B.id}"
    route_table_id = "${aws_vpc.HillelVPC.main_route_table_id}"
}

# Associate subnet private_subnet to private route table
resource "aws_route_table_association" "private_subnet_association_A" {
    subnet_id = "${aws_subnet.aws-subnet-private-A.id}"
    route_table_id = "${aws_route_table.private_route_table_A.id}"
}

resource "aws_route_table_association" "private_subnet_association_B" {
    subnet_id = "${aws_subnet.aws-subnet-private-B.id}"
    route_table_id = "${aws_route_table.private_route_table_B.id}"
}