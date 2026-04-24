resource "aws_db_instance" "todo_rds" {
  identifier             = "todo-mysql-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  db_name                = "tododb"
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "todo-mysql-db"
  }
}
