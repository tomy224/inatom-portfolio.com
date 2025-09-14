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