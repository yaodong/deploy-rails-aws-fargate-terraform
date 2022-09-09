resource "aws_cloudwatch_log_group" "app" {
  name = "/aws/ecs/${var.product}/${var.env}/app"

  tags = {
    Product     = var.product
    Environment = var.env
  }
}
