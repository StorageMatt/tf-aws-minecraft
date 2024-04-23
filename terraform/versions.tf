terraform {
  backend "s3" {
    key            = "terraform-aws/minecraft_server/terraform.tfstate"
    dynamodb_table = "terraform-statelock"
    region         = "eu-west-2"
  }
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
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
