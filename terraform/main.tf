# S3 Bucket for website hosting
resource "aws_s3_bucket" "portfolio" {
  bucket = "inatom-portfolio.com"
}

resource "aws_s3_bucket_website_configuration" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# ACM Certificate
resource "aws_acm_certificate" "portfolio" {
  provider          = aws.us_east_1
  domain_name       = "inatom-portfolio.com"
  subject_alternative_names = ["www.inatom-portfolio.com"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "portfolio" {
  origin {
    domain_name = aws_s3_bucket.portfolio.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.portfolio.bucket}"
    origin_access_control_id = "E2AOVSIH54GZRA"
  }

  enabled             = true
  default_root_object = "index.html"
  aliases = ["inatom-portfolio.com", "www.inatom-portfolio.com"]

  default_cache_behavior {
    target_origin_id         = "S3-${aws_s3_bucket.portfolio.bucket}"
    viewer_protocol_policy   = "redirect-to-https"
    allowed_methods         = ["GET", "HEAD"]
    cached_methods          = ["GET", "HEAD"]
    compress                = true
    cache_policy_id         = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.portfolio.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

# Route53 Hosted Zone
resource "aws_route53_zone" "portfolio" {
  name = "inatom-portfolio.com"
}

# Route53 Records
resource "aws_route53_record" "portfolio_a" {
  zone_id = aws_route53_zone.portfolio.zone_id
  name    = "inatom-portfolio.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.portfolio.domain_name
    zone_id                = aws_cloudfront_distribution.portfolio.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "portfolio_www" {
  zone_id = aws_route53_zone.portfolio.zone_id
  name    = "www.inatom-portfolio.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.portfolio.domain_name
    zone_id                = aws_cloudfront_distribution.portfolio.hosted_zone_id
    evaluate_target_health = false
  }
}