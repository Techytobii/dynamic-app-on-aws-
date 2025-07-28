output "cluster_name" {
  value = aws_ecs_cluster.webapp_cluster.name
}

output "service_name" {
  value = aws_ecs_service.webapp_service.name
}
