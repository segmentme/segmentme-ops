variable "project_name" {
    description = "Name of the project"
    default = "segmentme"
    type = string
}

variable "eks_instance_type" {
    description = "Type of instances which will be used for running eks node "
    default = "t3.small"
}

variable "tls_certificate_arn" {
    description = "certificate arn"
    type = string
}

variable "route_53_hosted_zone" {
    description = "Route53 Hosted zone which need to be updated with A record pointed to created ALB"
    type = string
}

variable "environment" {
    description = "Environment name"
    default = "demo"
    type = string
}


variable "owner" {
    description = "Owner of the environment"
    default = "devops"
    type = string
}

variable "region" {
    default = "us-east-1"
    description = "AWS region"
    type = string
}

locals {
    global_prefix = "${var.project_name}-${var.environment}"
    cluster_name = "${local.global_prefix}-eks"
    redis_cluster_name = "${local.global_prefix}-redis"
    default_tags = {
        Environment = var.environment
        GithubRepo = "segmentme-ops"
        GithubOrg = "segmentme"
    }
}