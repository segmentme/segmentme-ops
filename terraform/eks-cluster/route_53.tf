data "aws_route53_zone" "selected" {
  name         = var.route_53_hosted_zone
  private_zone = false
}


resource "aws_route53_record" "added-a-record" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = data.aws_route53_zone.selected.name
  type    = "A"

  alias {
    name                   = "dualstack.${aws_lb.alb.dns_name}"
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "added-web-api-record" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "api.${data.aws_route53_zone.selected.name}"
  type    = "A"

  alias {
    name                   = "dualstack.${aws_lb.alb.dns_name}"
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}