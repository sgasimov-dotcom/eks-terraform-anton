# https://www.youtube.com/watch?v=MZyrxzb7yAU&ab_channel=AntonPutra

provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
