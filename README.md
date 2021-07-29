![Latest GitHub Release](https://img.shields.io/github/v/release/byu-oit/terraform-aws-sns-slack-lambda?sort=semver)

# SNS to Slack Lambda

Terraform module to create a Lambda that can transform SNS notifications and send them to Slack.

#### [New to Terraform Modules at BYU?](https://devops.byu.edu/terraform/index.html)

## Usage

1. Create a [Slack webhook](https://api.slack.com/messaging/webhooks) and generate a webhook URL.
2. Include this module in your project.
3. Create [SNS topic subscriptions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) from the Lambda function created by this module to the SNS topic you'd like to post in Slack.

```hcl
module "sns_slack_lambda" {
  source = "github.com/byu-oit/terraform-aws-sns-slack-lambda?ref=v1.0.0"
}
```

## Requirements

* Terraform version 0.14.11 or greater
* AWS provider version 3.0.0 or greater

## Inputs

| Name | Type  | Description | Default |
| --- | --- | --- | --- |
| app_name | string | The application name to include in the name of resources created. |
| log_retention_in_days | number | The number of days to retain logs for the sns-to-slack Lambda. | 14 |
| memory_size | number | The amount of memory for the function | 128 |
| private_subnet_ids | list (string) | A list of subnet IDs in the private subnet of the VPC. |
| role_permissions_boundary | string | The ARN of the role permissions boundary to attach to the Lambda role. |
| slack_webhook_url | string | The webhook URL to use when sending messages to Slack. This value contains a secret and should be kept safe. |
| timeout | number | The number of seconds the function is allowed to run. | 30 |
| tags | map(string) | A map of AWS Tags to attach to each resource created. |
| vpc_id | string | The ID of the VPC the Lambda should be in. |


## Outputs

| Name | Type | Description |
| ---  | ---  | --- |
| lambda_function_arn | string | The ARN of teh Lambda function created. |
