output "sql_arn_id" {
  value = aws_db_instance.sql_server.arn
}
output "sql_endpoint" {
  value = aws_db_instance.sql_server.address
}

output "private_subnet_ids" {
  value = data.aws_subnets.private.ids
}

output "sql_security_group_id" {
  value = aws_security_group.sql_server_sg.id
}