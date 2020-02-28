resource "aws_route53_zone" "primary" {
  name = "cliente365.com.br"
}

resource "aws_route53_record" "www2" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www2"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.eip_web.public_ip}"]
}