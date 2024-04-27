terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  profile = var.aws_credentials_profile
  region  = var.aws_region
  default_tags {
    tags = {
      Name       = var.resource_name_prefix
      Project    = "Minecraft"
      DeployedBy = "Terraform"
    }
  }
}
