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