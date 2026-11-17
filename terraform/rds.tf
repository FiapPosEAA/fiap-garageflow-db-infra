resource "aws_security_group" "sql_server_sg" {
  name        = "garage-flow-sg"
  description = "Security group for the private GarageFlow RDS instance"
  vpc_id      = data.aws_vpc.garage_flow.id

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.garage_flow.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "sql_server" {
  name       = "garage-flow-db-subnets"
  subnet_ids = data.aws_subnets.private.ids
}

resource "aws_db_instance" "sql_server" {
  engine                 = "sqlserver-ex"
  instance_class         = "db.t3.micro"
  username               = var.sql_db_user
  password               = var.sql_db_password
  allocated_storage      = 20
  identifier             = var.sql_db_name
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.sql_server.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.sql_server_sg.id]
}
