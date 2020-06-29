variable "region" {
	type    = string
	default = "eu-east-1"
}

variable "aws-ec2-ami-id" {
	type    = string
    default = "ami-0affd4508a5d2481b"
}

variable "aws-ec2-type" {
	type    = string
	default = "t2.micro"
}

variable "aws-key-name" {
	type    = string
	default = "key_centos"
}