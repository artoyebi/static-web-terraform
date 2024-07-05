variable "bucket_name" {
  description = "The name of the S3 bucket."
  default = "myaltschool-static-website-bucket-563532017"
}

variable "website_index" {
  description = "The index document for the website."
  default     = "index.html"
}

variable "website_error" {
  description = "The error document for the website."
  default     = "error.html"
}
