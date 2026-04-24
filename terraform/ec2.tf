data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "todo_ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

  key_name = "whiteboard-key2"
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io awscli

              systemctl start docker
              systemctl enable docker

              # Login to ECR
              aws ecr get-login-password --region ap-south-1 | \
              docker login --username AWS --password-stdin ${aws_ecr_repository.todo_repo.repository_url}

              # Fetch DB credentials from SSM Parameter Store
              DB_USER=$(aws ssm get-parameter --name "/todoapp/db_username" --with-decryption --query Parameter.Value --output text --region ap-south-1)
              DB_PASS=$(aws ssm get-parameter --name "/todoapp/db_password" --with-decryption --query Parameter.Value --output text --region ap-south-1)

              # Run container
              docker run -d -p 8080:8080 \
              -e DB_HOST=${aws_db_instance.todo_rds.address} \
              -e DB_PORT=3306 \
              -e DB_USER=$DB_USER \
              -e DB_PASS=$DB_PASS \
              -e DB_NAME=tododb \
              ${aws_ecr_repository.todo_repo.repository_url}:latest
              EOF

  tags = {
    Name = "todo-ec2"
  }

  depends_on = [aws_db_instance.todo_rds]
}
