resource "aws_s3_bucket" "s3_web" {
  bucket = "web-aprenda-nuvem"
  acl    = "private"

  tags = {
    Name        = "S3 Aprenda Nuvem"
    Environment = "Dev"
  }
}