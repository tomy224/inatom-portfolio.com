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