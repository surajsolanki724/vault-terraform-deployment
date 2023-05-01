terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
  }
}

provider "vault" {
  address = "${var.vault_address}"
  auth_login {
    path = "auth/userpass/login/${var.vault_username}"
    parameters = {
      password = var.vault_password
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "infra/terraform.tfstate"
    region         = "ap-south-1"
    # dynamodb_table = "terraform-state-lock-table"
    # encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}