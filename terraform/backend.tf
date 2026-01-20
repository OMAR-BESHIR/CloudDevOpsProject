terraform {
  backend "s3" {
    bucket = "ivolve-project1645356121"
    key    = "clouddevopsproject/terraform.tfstate"
    region = "us-east-1"
  }
}
