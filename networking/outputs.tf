output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "route_53_name_servers" {
  value = aws_route53_zone.this.name_servers
}

output "acm_arn" {
  value = aws_acm_certificate.this.arn
}

output "load_balancer_id" {
  value = aws_alb.this.id
}

output "load_balancer_security_group_id" {
  value = aws_security_group.load_balancer.id
}

output "db_security_group_id" {
  value = aws_security_group.db.id
}

output "app_security_group_id" {
  value = aws_security_group.app.id
}

output "app_target_group_arn" {
  value = aws_alb_target_group.app.arn
}

output "ecs_security_group_id" {
  value = aws_security_group.ecs.id
}
