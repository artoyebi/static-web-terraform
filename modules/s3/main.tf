resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket          = aws_s3_bucket.this.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.this.bucket
  key    = "index.html"
  source = "website/index.html"
  acl    = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "styles" {
  bucket = aws_s3_bucket.this.bucket
  key    = "styles.css"
  source = "website/styles.css"
  acl    = "public-read"
  content_type = "text/css"
}

resource "aws_s3_bucket_object" "images" {
  for_each = fileset("website/images", "*")
  bucket   = aws_s3_bucket.this.bucket
  key      = "images/${each.value}"
  source   = "website/images/${each.value}"
  acl      = "public-read"
  content_type = "image/png"
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "bucket_domain_name" {
  value = aws_s3_bucket.this.website_endpoint
}
