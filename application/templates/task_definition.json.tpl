[
  {
    "name": "app",
    "image": "${image}",
    "environment": [
      {
        "name": "RAILS_ENV",
        "value": "${env}"
      },
      {
        "name": "RAILS_HOST",
        "value": "${domain_name}"
      },
      {
        "name": "DATABASE_URL",
        "value": "${database_url}"
      },
      {
        "name": "RAILS_LOG_TO_STDOUT",
        "value": "1"
      },
      {
        "name": "RAILS_SERVE_STATIC_FILES",
        "value": "1"
      }
    ],
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "task"
      }
    },
    "secrets": [
      {
        "name": "DATABASE_PASSWORD",
        "valueFrom": "${secret_arn}:DATABASE_PASSWORD::"
      },
      {
        "name": "RAILS_MASTER_KEY",
        "valueFrom": "${secret_arn}:RAILS_MASTER_KEY::"
      }
    ]
  }
]
