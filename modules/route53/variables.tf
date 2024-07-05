variable "domain_name" {
  description = "The domain name for the website."
}

variable "cloudfront_dns" {
  description = "The CloudFront domain name."
}

variable "cloudfront_zone_id" {
  description = "The CloudFront hosted zone ID."
}

variable "zone_id" {
  description = "The Route 53 hosted zone ID."
}