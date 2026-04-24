resource "aws_ecr_repository" "todo_repo" {
  name                 = "todoapp-repo"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = { Name = "todoapp-repo" }
}

resource "aws_ecr_lifecycle_policy" "todo_repo_policy" {
  repository = aws_ecr_repository.todo_repo.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 5 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 5
      }
      action = { type = "expire" }
    }]
  })
}
