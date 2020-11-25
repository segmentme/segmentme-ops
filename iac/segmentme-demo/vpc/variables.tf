variable "project_name" {
  description = "Name of the project"
  default = "segmentme"
}

variable "environment" {
  description = "Environment name"
  default = "demo"
}

variable "bastion_ami_id" {
  description = "Bastion AMI id"
  default = "ami-04bf6dcdc9ab498ca"
}


variable "owner" {
  description = "Owner of the environment"
  default = "devops"
}