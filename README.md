![Latest GitHub Release](https://img.shields.io/github/v/release/byu-oit/terraform-aws-sns-slack-lambda?sort=semver)

# SNS to Slack Lambda

Terraform module to create a Lambda that can transform SNS notifications and send them to Slack.

#### [New to Terraform Modules at BYU?](https://devops.byu.edu/terraform/index.html)

## Usage

```hcl
module "sns_slack_lambda" {
  source = "github.com/byu-oit/terraform-aws-sns-slack-lambda?ref=v1.0.0"
}
```

## Requirements

* Terraform version 0.12.31 or greater
* AWS provider version 3.0.0 or greater

## Inputs

| Name | Type  | Description | Default |
| --- | --- | --- | --- |
| | | | |

## Outputs

| Name | Type | Description |
| ---  | ---  | --- |
| | | |
