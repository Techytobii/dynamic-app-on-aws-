resource "aws_ecr_repository" "webapp_repo" {
  name = var.repository_name
}
