output "ec2_public_ip" {
  value = aws_instance.todo_ec2.public_ip
}

output "rds_endpoint" {
  value     = aws_db_instance.todo_rds.address
  sensitive = true
}

output "ecr_repo_url" {
  value = aws_ecr_repository.todo_repo.repository_url
}
