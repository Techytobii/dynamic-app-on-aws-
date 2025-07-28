output "repository_url" {
  value = data.aws_ecr_repository.webapp_repo.repository_url
}

output "ecs_service" {
  value = aws_ecs_service.webapp_service.name
}
