# https://www.youtube.com/watch?v=MZyrxzb7yAU&ab_channel=AntonPutra

provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.13.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
     kubernetes = "~> 1.11" 
  }
}
