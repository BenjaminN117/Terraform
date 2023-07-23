terraform {
  backend "s3" {
    bucket = "dev-terraform-profile"
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-2"
  }
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}