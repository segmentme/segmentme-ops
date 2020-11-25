variable "bastion_key_pair_name" {
  description = "Name of the key pair"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "allowed_cidr_block" {
  type    = list(string)
  description = "Allow CIDR block"
}

variable "vpc_subnet_id" {
  description = "VPC subnet"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "ami_id" {
  description = "Bastion AMI id"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}