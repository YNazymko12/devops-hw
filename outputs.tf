output "s3_bucket_name" {
  description = "terraform-state-lesson5-us-east-1"
  value       = module.s3_backend.s3_bucket_name
}

output "dynamodb_table_name" {
  description = "terraform-state-lock-lesson5"
  value       = module.s3_backend.dynamodb_table_name
}

output "ecr_repository_url" {
  description = "URL ECR-репозиторію для використання в docker push"
  value       = module.ecr.repository_url
}

output "ecr_repository_name" {
  description = "Ім'я ECR-репозиторію"
  value       = module.ecr.repository_name
}