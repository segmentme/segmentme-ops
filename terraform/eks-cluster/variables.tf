variable "project_name" {
    description = "Name of the project"
    default = "segmentme"
}

variable "environment" {
    description = "Environment name"
    default = "demo"
}


variable "owner" {
    description = "Owner of the environment"
    default = "devops"
}

variable "region" {
    default = "us-east-1"
    description = "AWS region"
}

locals {
    global_prefix = "${var.project_name}-${var.environment}"
    cluster_name = "${local.global_prefix}-eks"
    redis_cluster_name = "${local.global_prefix}-redis"
}