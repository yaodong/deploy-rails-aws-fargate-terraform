resource "aws_security_group" "load_balancer" {
  name        = "${var.product}-${var.env}-load-balancer"
  description = "controls access to the the load balancer"
  vpc_id      = aws_vpc.this.id

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${title(var.product)} Load Balancer - ${title(var.env)}"
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_security_group" "ecs" {
  name        = format("%s-%s-ecs", var.product, var.env)
  description = "Control inbound access"
  vpc_id      = aws_vpc.this.id

  ingress {
    protocol        = "tcp"
    from_port       = 3000
    to_port         = 3000
    security_groups = [
      aws_security_group.load_balancer.id
    ]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${title(var.product)} ECS - ${title(var.env)}"
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_security_group" "db" {
  name   = format("%s-%s-db", var.product, var.env)
  vpc_id = aws_vpc.this.id

  lifecycle {
    create_before_destroy = true
  }

  # allows traffic from itself
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  # allow traffic for TCP 5432
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  # allow outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${title(var.product)} RDS - ${title(var.env)}"
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_security_group" "app" {
  vpc_id      = aws_vpc.this.id
  name        = format("%s-%s-app", var.product, var.env)
  description = "Security group for the app"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${title(var.product)} App - ${title(var.env)}"
    Product     = var.product
    Environment = var.env
  }
}
