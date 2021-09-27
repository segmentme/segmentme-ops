variable "project_name" {
  description = "Name of the project"
  default     = "segmentme"
  type        = string
}

variable "AUTH0_CLIENT_ID" {
  description = "Auth0 client id required to be set in secret manager. This value should be declared as secret environment in tf cloud"
  default     = "_"
  type        = string
}

variable "AUTH0_CLIENT_SECRET" {
  description = "Auth0 client secret required to be set in secret manager. This value should be declared as secret environment in tf cloud"
  default     = "_"
  type        = string
}

variable "SEGMENTME_DB_CONNECTOR_URI" {
  description = "MongoDB connection string required to be set in secret manager. This value should be declared as secret environment in tf cloud"
  default     = "_"
  type        = string
}

variable "eks_instance_type" {
  description = "Type of instances which will be used for running eks node "
  default     = "t3.small"
  type        = string
}

variable "tls_certificate_arn" {
  description = "certificate arn"
  type        = string
}

variable "route_53_hosted_zone" {
  description = "Route53 Hosted zone which need to be updated with A record pointed to created ALB"
  type        = string
}

variable "environment" {
  description = "Environment name"
  default     = "demo"
  type        = string
}


variable "owner" {
  description = "Owner of the environment"
  default     = "devops"
  type        = string
}

variable "region" {
  default     = "us-east-1"
  description = "AWS region"
  type        = string
}

locals {
  global_prefix      = "${var.project_name}-${var.environment}"
  cluster_name       = "${local.global_prefix}-eks"
  redis_cluster_name = "${local.global_prefix}-redis"
  default_tags = {
    Environment = var.environment
    GithubRepo  = "segmentme-ops"
    GithubOrg   = "segmentme"
  }
}