variable "project" {}
variable "ami_id" {}
variable "public_subnets" {
  type = list(string)
}
variable "vpc_id" {}

