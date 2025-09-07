output "repository_url" {
  description = "Повний URL ECR-репозиторію"
  value       = aws_ecr_repository.this.repository_url
}

output "registry_id" {
  description = "ID реєстру (акаунту AWS)"
  value       = aws_ecr_repository.this.registry_id
}

output "repository_name" {
  description = "Ім'я репозиторію"
  value       = aws_ecr_repository.this.name
}