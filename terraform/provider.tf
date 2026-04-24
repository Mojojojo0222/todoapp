terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # backend "s3" {
  #   bucket         = "your-tfstate-bucket"
  #   key            = "todoapp/terraform.tfstate"
  #   region         = "ap-south-1"
  #   dynamodb_table = "terraform-lock"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = "ap-south-1"
}
