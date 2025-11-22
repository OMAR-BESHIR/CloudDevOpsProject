 terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "clouddevopsproject/terraform.tfstate"
    region = "us-east-1"
  }
 } 
