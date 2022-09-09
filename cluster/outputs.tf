output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}
