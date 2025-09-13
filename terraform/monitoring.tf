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