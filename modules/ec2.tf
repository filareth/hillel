resource "aws_instance" "centos7" {
  ami 			= "var.aws-ec2-ami-id"
  instance_type = "var.aws-ec2-type"
  key_name 		= "var.aws-key-name"
  
  vpc_security_group_ids = ["aws_security_group.allow_ssh.id"]

  tags = {
    Name = "Centos7 Nginx PHP"
  }
}