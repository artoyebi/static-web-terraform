output "s3_bucket_name" {
  value = module.s3_bucket.bucket_name
}

output "cloudfront_domain_name" {
  value = module.cloudfront.cloudfront_domain_name
}

output "route53_zone_id" {
  value = module.route53.zone_id
}
