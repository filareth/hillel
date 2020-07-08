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
  default = "key_centos"
}

#vpc_cidr - это блок для использования внутри всей VPC
variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "172.20.0.0/16"
}

#vpc_cidr_public - блок для публичных сервисов (например, для ssh proxy AKA bastion host или балансировщика)
variable "vpc_cidr_public" {
    description = "CIDR for the Public subnet"
    default = "172.20.0.0/24"
}

#vpc_cidr_private - это блок для внутренних сервисов (например сервер БД или воркеры с приложениями)
variable "vpc_cidr_private" {
    description = "CIDR for the Private subnet"
    default = "172.20.1.0/24"
}