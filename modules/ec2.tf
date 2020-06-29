############################################################################
# INSTANCE
############################################################################
resource "aws_instance" "centos7" {
  ami 			= data.aws_ami.centos7.id
  instance_type = "t2.micro"
  key_name      = "key_centos"
  
  vpc_security_group_ids = ["aws_security_group.allow_ssh.id"]

  tags = {
    Name = "Centos7 Nginx PHP"
  }
}