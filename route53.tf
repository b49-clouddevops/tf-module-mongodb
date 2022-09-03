resource "aws_route53_record" "www" {
    # I'd need the zone details, which we have given in the vpc module, so we need to fetch the zone id from there. We are can read remote state from their outputs
  zone_id = data.terraform_remote_state.vpc.outputs.HOSTEDZONE_PUBLIC_ZONE
  name    = "mongodb-${var.ENV}"
  type    = "CNAME"
  ttl     = 660
  records = [aws_eip.lb.public_ip]
}