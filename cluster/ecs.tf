resource "aws_ecs_cluster" "this" {
  name = format("%s-%s", var.product, var.env)

  tags = {
    Product     = var.product
    Environment = var.env
  }
}
