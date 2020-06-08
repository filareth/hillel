variable "region" {
	type    = string
	default = "eu-east-1"
}

variable "instance_type" {
        type    = string
        default = "t2.micro"
}

variable "key_file" {
        type    = string
        default = "key_centos7"
}
