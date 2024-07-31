terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "default"
  region = "us-west-2"
}

provider "aws" {
  alias  = "another_region"
  region = "us-east-1"
}


