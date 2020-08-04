variable "region" {
	type    = string
	default = "eu-east-1"
}

variable "aws-ec2-ami-id" {
      default = "ami-0affd4508a5d2481b"
}

variable "aws-ec2-type" {
  default = "t2.micro"
}

variable "aws-key-name" {
  default = "key_instance"
}
