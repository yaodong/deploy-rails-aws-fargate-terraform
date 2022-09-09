resource "aws_route53_zone" "this" {
  name = var.domain_name

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_route53_record" "alb" {
  name    = var.domain_name
  zone_id = aws_route53_zone.this.id
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = aws_alb.this.dns_name
    zone_id                = aws_alb.this.zone_id
  }
}
