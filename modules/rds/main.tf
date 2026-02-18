resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "this" {
  identifier              = var.db_name
  engine                  = "postgres"
  instance_class          = "db.t3.medium"
  allocated_storage       = 20
  username                = "postgres"
  password                = "ChangeMe123!"
  multi_az                = true
  storage_encrypted       = true
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.this.name
  skip_final_snapshot     = true
}
