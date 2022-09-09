# service for running the Rails app
resource "aws_ecs_service" "app" {
  name            = "app"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"

  health_check_grace_period_seconds = 300

  network_configuration {
    subnets         = var.vpc_private_subnet_ids
    security_groups = [
      var.ecs_security_group_id,
      var.app_security_group_id
    ]
  }

  load_balancer {
    target_group_arn = var.app_target_group_arn
    container_name   = "app"
    container_port   = 3000
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.product}-${var.env}-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = var.ecs_task_execution_role_arn

  lifecycle {
    create_before_destroy = true
  }

  container_definitions = data.template_file.app_task_definition.rendered

  tags = {
    Product     = var.product
    Environment = var.env
  }
}

data "template_file" "app_task_definition" {
  template = file("templates/task_definition.json.tpl")

  vars = {
    product        = var.product
    env            = var.env
    region         = var.region
    image          = "${var.ecr_repository_url}:${var.docker_image_tag}"
    domain_name    = var.domain_name
    database_url   = "postgres://${var.product}_${var.env}@${var.database_endpoint}"
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    log_group      = aws_cloudwatch_log_group.app.name
    secret_arn     = var.secret_arn
  }
}
