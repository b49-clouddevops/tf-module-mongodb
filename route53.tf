resource "aws_route53_record" "www" {
    # I'd need the zone details, which we have given in the vpc module, so we need to fetch the zone id from there. We are can read remote state from their outputs
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.example.com"
  type    = "A"
  ttl     = 300
  records = [aws_eip.lb.public_ip]
}