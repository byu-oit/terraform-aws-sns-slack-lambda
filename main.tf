terraform {
  required_version = ">= 0.14.11"
  required_providers {
    aws = ">= 3.0"
  }
}

resource "aws_lambda_function" "sns_to_slack" {
  function_name = "${var.app_name}-sns-to-slack"
  filename      = "${path.module}/lambda/function.zip"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  role          = aws_iam_role.sns_to_slack.arn
  timeout       = var.timeout
  memory_size   = var.memory_size
  tags          = var.tags

  environment {
    variables = {
      SLACK_WEBHOOK_URL = var.slack_webhook_url
    }
  }

  vpc_config {
    security_group_ids = [aws_security_group.sns_to_slack.id]
    subnet_ids         = var.private_subnet_ids
  }
}

resource "aws_security_group" "sns_to_slack" {
  name   = "${var.app_name}-sns-to-slack"
  vpc_id = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_iam_role" "sns_to_slack" {
  name                 = "${var.app_name}-sns-to-slack-role"
  permissions_boundary = var.role_permissions_boundary
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.sns_to_slack.name
}

resource "aws_iam_role_policy_attachment" "logging_eni_attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaENIManagementAccess"
  role       = aws_iam_role.sns_to_slack.name
}

resource "aws_cloudwatch_log_group" "logging" {
  name              = "/aws/lambda/${aws_lambda_function.logging.function_name}"
  retention_in_days = var.log_retention_in_days
}