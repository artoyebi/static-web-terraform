module "s3_bucket" {
  source        = "./modules/s3"
  bucket_name   = var.s3_bucket_name
  website_index = "index.html"
  website_error = "error.html"
}

module "cloudfront" {
  source              = "./modules/cloudfront"
  s3_bucket_domain    = module.s3_bucket.bucket_domain_name
  acm_certificate_arn = var.certificate_arn
  domain_name         = var.domain_name
}

module "route53" {
  source             = "./modules/route53"
  domain_name        = var.domain_name
  cloudfront_dns     = module.cloudfront.cloudfront_domain_name
  cloudfront_zone_id = module.cloudfront.cloudfront_zone_id
  zone_id            = aws_route53_zone.primary.zone_id
}
