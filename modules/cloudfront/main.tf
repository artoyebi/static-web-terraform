resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = var.s3_bucket_domain
    origin_id   = var.s3_bucket_domain

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  enabled = true
  is_ipv6_enabled = true
  comment = "CDN for ${var.s3_bucket_domain}"
  default_root_object = "index.html"

  aliases = [var.domain_name]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_bucket_domain

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # depends_on = [ aws_acm_certificate_validation.this ]
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "OAI for ${var.s3_bucket_domain}"
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_zone_id" {
  value = aws_cloudfront_distribution.this.hosted_zone_id
}
