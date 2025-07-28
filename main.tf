provider "aws" {
  region  = "us-east-1"
  profile = "CloudTrailS3EC2FromTerraform-465828358642"
}

data "aws_ecr_repository" "webapp_repo" {
  name = "webapp-repo"
}

resource "aws_ecs_cluster" "webapp_cluster" {
  name = "webapp-cluster"
}

resource "aws_ecs_task_definition" "webapp_task" {
  family                   = "webapp-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::465828358642:role/ecsTaskExecutionRoleManual"

  container_definitions = jsonencode([
    {
      name      = "webapp",
      image     = data.aws_ecr_repository.webapp_repo.repository_url,
      essential = true,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80,
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "webapp_service" {
  name            = "webapp-service"
  cluster         = aws_ecs_cluster.webapp_cluster.id
  task_definition = aws_ecs_task_definition.webapp_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }
}
