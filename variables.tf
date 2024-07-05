variable "region" {
  description = "The AWS region to create resources in."
  default     = "us-east-1"
}

variable "domain_name" {
  description = "The domain name for the website."
  default = "artoyebi.dev"
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate."
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket."
  default = "my-static-website-bucket-563532017"
}
