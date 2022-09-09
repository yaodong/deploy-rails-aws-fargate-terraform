# user used by app codes
resource "aws_iam_user" "app" {
  name = format("%s%sUserForAppRuntime", title(var.product), title(var.env))

  tags = {
    Product     = var.product
    Environment = var.env
  }
}

# role used by cluster task execution
resource "aws_iam_role" "ecs_task_execution" {
  name               = format("%s%sRoleForTaskExecution", title(var.product), title(var.env))
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json

  tags = {
    Product     = var.product
    Environment = var.env
  }
}

# attach ecs task execution policy
resource "aws_iam_role_policy_attachment" "task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# allow cluster to access app secret
resource "aws_iam_role_policy_attachment" "secret_role_attach" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.read_secret.arn
}

resource "aws_iam_policy" "read_secret" {
  name   = format("%s%sSecretReadOnlyAccess", title(var.product), title(var.env))
  policy = data.aws_iam_policy_document.read_secret.json
}

# allow app user to send email
resource "aws_iam_user_policy_attachment" "app_user_attach" {
  user       = aws_iam_user.app.name
  policy_arn = aws_iam_policy.send_email.arn
}

resource "aws_iam_policy" "send_email" {
  name   = format("%s%sEmailSending", title(var.product), title(var.env))
  policy = data.aws_iam_policy_document.send_email.json
}

data "aws_iam_policy_document" "send_email" {
  statement {
    actions   = ["ses:SendRawEmail"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "read_secret" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [
      var.secret_arn
    ]
  }
}

data "aws_iam_policy_document" "ecs_task_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
