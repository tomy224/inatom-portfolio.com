# monitoring.tf

# SNS Topic for alerts
resource "aws_sns_topic" "portfolio_alerts" {
  name = "portfolio-monitoring-alerts"
  
  tags = {
    Environment = "production"
    Purpose     = "monitoring"
  }
}

# CloudFront 4xx Error Rate Alarm
resource "aws_cloudwatch_metric_alarm" "cloudfront_4xx_errors" {
  alarm_name          = "portfolio-cloudfront-4xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "4xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = "300"
  statistic           = "Average"
  threshold           = "10"
  alarm_description   = "This metric monitors CloudFront 4xx error rate"
  alarm_actions       = [aws_sns_topic.portfolio_alerts.arn]
  
  dimensions = {
    DistributionId = "E1P62XGQRY77C3"
  }

  tags = {
    Environment = "production"
    Purpose     = "monitoring"
  }
}

# CloudFront 5xx Error Rate Alarm
resource "aws_cloudwatch_metric_alarm" "cloudfront_5xx_errors" {
  alarm_name          = "portfolio-cloudfront-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "5xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = "300"
  statistic           = "Average"
  threshold           = "5"
  alarm_description   = "This metric monitors CloudFront 5xx error rate"
  alarm_actions       = [aws_sns_topic.portfolio_alerts.arn]
  
  dimensions = {
    DistributionId = "E1P62XGQRY77C3"
  }

  tags = {
    Environment = "production"
    Purpose     = "monitoring"
  }
}


# CloudFront Origin Latency Alarm
resource "aws_cloudwatch_metric_alarm" "cloudfront_latency" {
  alarm_name          = "portfolio-cloudfront-high-latency"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "OriginLatency"
  namespace           = "AWS/CloudFront"
  period              = "300"
  statistic           = "Average"
  threshold           = "1000"
  alarm_description   = "This metric monitors CloudFront origin latency"
  alarm_actions       = [aws_sns_topic.portfolio_alerts.arn]
  
  dimensions = {
    DistributionId = "E1P62XGQRY77C3"
  }

  tags = {
    Environment = "production"
    Purpose     = "monitoring"
  }
}

# Email notification subscription
resource "aws_sns_topic_subscription" "email_alerts" {
  topic_arn = aws_sns_topic.portfolio_alerts.arn
  protocol  = "email"
  endpoint  = "parmenara@gmail.com"
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

# SLI/SLO定義のための複合アラーム
resource "aws_cloudwatch_composite_alarm" "portfolio_availability_sli" {
  alarm_name        = "portfolio-availability-sli"
  alarm_description = "Availability SLI: Tracks 99.9% uptime objective"
  
  alarm_rule = "ALARM(${aws_cloudwatch_metric_alarm.cloudfront_4xx_errors.alarm_name}) OR ALARM(${aws_cloudwatch_metric_alarm.cloudfront_5xx_errors.alarm_name})"

  actions_enabled = true
  alarm_actions   = [aws_sns_topic.portfolio_alerts.arn]
}

# エラーバジェット追跡用メトリクス
resource "aws_cloudwatch_metric_alarm" "error_budget_alarm" {
  alarm_name          = "portfolio-error-budget-exhaustion"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "4xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = "3600"  # 1時間
  statistic           = "Average"
  threshold           = "0.1"   # 月間エラーバジェット 0.1%
  alarm_description   = "Error Budget: Monthly downtime budget (43.2 min) tracking"
  
  dimensions = {
    DistributionId = "E1P62XGQRY77C3"
  }
  
  alarm_actions = [aws_sns_topic.portfolio_alerts.arn]
}

# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "portfolio_sre_dashboard" {
  dashboard_name = "Portfolio-SRE-Monitoring"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/CloudFront", "Requests", "DistributionId", "E1P62XGQRY77C3"],
            [".", "4xxErrorRate", ".", "."],
            [".", "5xxErrorRate", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "us-east-1"
          title   = "Portfolio SLI Metrics"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["Portfolio/Health", "SiteAvailability"],
            [".", "ResponseTime"]
          ]
          view   = "timeSeries"
          region = "us-east-1"
          title  = "Custom SLI Metrics"
          period = 300
          yAxis = {
            left = {
              min = 0
              max = 1
            }
          }
        }
      }
    ]
  })
}