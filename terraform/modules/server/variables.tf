variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}
variable "instance_type" {
  description = "The type of instance to use"
  type        = string
}
variable "key_name" {
  description = "The name of the key pair"
  type        = string
}