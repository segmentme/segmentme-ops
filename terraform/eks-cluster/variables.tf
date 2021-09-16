variable "project_name" {
    description = "Name of the project"
    default = "segmentme"
}

variable "tls_certificate_arn" {
    description = "certificate arn"
}

variable "route_53_hosted_zone" {
    description = "Route53 Hosted zone which need to be updated with A record pointed to created ALB"
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
    default_tags = {
        Environment = var.environment
        GithubRepo = "segmentme-ops"
        GithubOrg = "segmentme"
    }
}