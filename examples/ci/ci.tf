terraform {
  required_version = ">= 0.12.31"
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
}

module "ci_test" {
  source = "../../"
}
