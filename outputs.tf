output "s3_bucket_name" {
  description = "terraform-state-lesson5-us-east-1"
  value       = module.s3_backend.s3_bucket_name
}

output "dynamodb_table_name" {
  description = "terraform-state-lock-lesson5"
  value       = module.s3_backend.dynamodb_table_name
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "ecr_repository_url" {
  description = "URL ECR-репозиторію для використання в docker push"
  value       = module.ecr.repository_url
}

output "ecr_repository_name" {
  description = "Ім'я ECR-репозиторію"
  value       = module.ecr.repository_name
}

output "eks_cluster_endpoint" {
  description = "EKS API endpoint for connecting to the cluster"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.eks_cluster_name
}

output "eks_node_role_arn" {
  description = "IAM role ARN for EKS Worker Nodes"
  value       = module.eks.eks_node_role_arn
}
