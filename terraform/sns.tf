# SNS Topic for alerts
resource "aws_sns_topic" "portfolio_alerts" {
  name = "portfolio-monitoring-alerts"
  
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