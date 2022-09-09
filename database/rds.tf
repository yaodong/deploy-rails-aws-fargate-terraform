resource "aws_db_subnet_group" "this" {
  name       = format("%s-%s-private", var.product, var.env)
  subnet_ids = var.vpc_private_subnet_ids

  tags = {
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_db_instance" "this" {
  identifier              = format("%s-%s", var.product, var.env)
  availability_zone       = var.availability_zone
  allocated_storage       = var.allocated_storage
  backup_retention_period = var.backup_retention_period
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = lower(format("%s_%s", var.product, var.env))
  password                = local.database_password
  db_subnet_group_name    = aws_db_subnet_group.this.id
  vpc_security_group_ids  = [var.vpc_security_group_id]
  skip_final_snapshot     = true

  tags = {
    Product     = var.product
    Environment = var.env
  }
}


