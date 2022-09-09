resource "aws_alb" "this" {
  name            = "${var.product}-${var.env}"
  internal        = false
  security_groups = [aws_security_group.load_balancer.id]
  subnets         = tolist(aws_subnet.public.*.id)

  tags = {
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_alb_target_group" "app" {
  name        = "${var.product}-${var.env}-app"
  protocol    = "HTTP"
  port        = 3000
  target_type = "ip"
  vpc_id      = aws_vpc.this.id

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    path                = "/"
    port                = 3000
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = aws_acm_certificate.this.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app.arn
  }

  tags = {
    Product     = var.product
    Environment = var.env
  }
}
