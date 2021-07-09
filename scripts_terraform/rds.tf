resource "aws_db_instance" "rds" {
  identifier             = "rds"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.1"
  username               = "jose"
  password               = var.db_clave
  vpc_security_group_ids = ["sg-00ce84358e70ca4a7", ]
  publicly_accessible    = true
  skip_final_snapshot    = true
}