terraform {
   backend "s3" {
   bucket = "devops-terraform-hillel"
   key    = "dz3part2/terraform.tfstate"
   region = "us-east-1"
   dynamodb_table = "devops-terraform-hillel"
   shared_credentials_file = "/home/filareth/hillel/credentials"
   }
}

