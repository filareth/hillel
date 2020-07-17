data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

############################################################################
# SECURITY GROUP
############################################################################
resource "aws_security_group" "ssh_2" {
  name          = "vpc_private"
  description   = "Allow ssh inbound traffic"
  vpc_id        = aws_vpc.HillelVPC.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  tags = {
    Name = "ssh_2"
  }
}

############################################################################
# INSTANCE
############################################################################

resource "aws_instance" "ubuntu" {
    ami                    = data.aws_ami.ubuntu.id
    availability_zone      = "us-east-1a"
    instance_type          = "t2.micro"
    key_name               = "key_centos"
    subnet_id              = aws_subnet.test-private.id
    vpc_security_group_ids = ["${aws_security_group.ssh_2.id}"]
    source_dest_check      = false
    

    tags = {
      Name = "Ubuntu"
    }
}