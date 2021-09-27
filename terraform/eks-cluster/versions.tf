terraform {
  required_providers {
    helm = {
      version = ">=2.2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.54.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.4.1"
    }

  }

  required_version = "> 0.14"
}

