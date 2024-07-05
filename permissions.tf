resource "aws_iam_role" "cloudfront_access" {
  name = "cloudfront_access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  depends_on = [ module.s3_bucket ]
}

resource "aws_iam_policy" "s3_read_access" {
  name = "s3_read_access"
  description = "Allow CloudFront to read from S3 bucket"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "s3:GetObject",
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
      }
    ]
  })
  depends_on = [ module.s3_bucket ]
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role = aws_iam_role.cloudfront_access.name
  policy_arn = aws_iam_policy.s3_read_access.arn
  depends_on = [ aws_iam_role.cloudfront_access, aws_iam_policy.s3_read_access]
}
