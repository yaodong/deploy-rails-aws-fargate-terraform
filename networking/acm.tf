resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${title(var.product)} Certificate - ${title(var.env)}"
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for op in aws_acm_certificate.this.domain_validation_options : op.domain_name => {
      name   = op.resource_record_name
      record = op.resource_record_value
      type   = op.resource_record_type
    }
  }

  zone_id         = aws_route53_zone.this.zone_id
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "root" {
  certificate_arn = aws_acm_certificate.this.arn

  validation_record_fqdns = [
    for record in aws_route53_record.validation : record.fqdn
  ]
}
