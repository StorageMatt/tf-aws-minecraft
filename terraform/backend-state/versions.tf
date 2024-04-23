terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.1"
    }
  }
}

provider "aws" {
  profile = var.aws_credentials_profile
  region  = var.aws_region
  default_tags {
    tags = {
      Name       = "Minecraft"
      Project    = "Minecraft"
      DeployedBy = "Terraform"
    }
  }
}
