resource "aws_instance" "centos7" {
  ami 			= "ami-0affd4508a5d2481b"
  instance_type = "t2.micro"
  key_name 		= "key_centos"
  
  vpc_security_group_ids = ["aws_security_group.allow_ssh.id"]

  tags = {
    Name = "Centos7 Nginx PHP"
  }
}