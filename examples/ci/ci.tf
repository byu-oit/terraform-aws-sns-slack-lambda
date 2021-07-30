terraform {
  required_version = ">= 0.14.11"
  required_providers {
    aws = "~> 3.0"
  }
}

provider "aws" {
  region = "us-west-2"
}

module "ci_test" {
  source                    = "../../"
  app_name                  = "test"
  private_subnet_ids        = module.acs.private_subnet_ids
  role_permissions_boundary = module.acs.role_permissions_boundary.arn
  slack_webhook_url         = "https://api.slack.com/FAKE/URL"
}

module "acs" {
  source = "github.com/byu-oit/terraform-aws-acs-info?ref=v3.2.0"
}
