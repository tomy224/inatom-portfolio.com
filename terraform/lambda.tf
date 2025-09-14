# IAM role for Lambda
resource "aws_iam_role" "lambda_metrics_role" {
  name = "portfolio-lambda-metrics-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM policy for CloudWatch metrics
resource "aws_iam_role_policy" "lambda_metrics_policy" {
  name = "portfolio-lambda-metrics-policy"
  role = aws_iam_role.lambda_metrics_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "cloudwatch:PutMetricData"
        ]
        Resource = "*"
      }
    ]
  })
}

# Lambda function for custom metrics
resource "aws_lambda_function" "metrics_collector" {
  filename         = "metrics_collector.zip"
  function_name    = "portfolio-metrics-collector"
  role            = aws_iam_role.lambda_metrics_role.arn
  handler         = "index.handler"
  runtime         = "python3.9"
  timeout         = 30

  tags = {
    Environment = "production"
    Purpose     = "monitoring"
  }
}

# EventBridge rule for 15-minute execution
resource "aws_cloudwatch_event_rule" "metrics_schedule" {
  name                = "portfolio-metrics-schedule"
  description         = "Trigger portfolio metrics collection every 15 minutes"
  schedule_expression = "rate(15 minutes)"
}

# EventBridge target
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.metrics_schedule.name
  target_id = "PortfolioMetricsTarget"
  arn       = aws_lambda_function.metrics_collector.arn
}

# Lambda permission for EventBridge
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.metrics_collector.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.metrics_schedule.arn
}