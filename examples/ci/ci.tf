terraform {
  required_version = ">= 0.14.11"
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
}

module "ci_test" {
  source = "../../"
}
