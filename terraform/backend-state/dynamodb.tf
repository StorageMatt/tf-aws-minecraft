resource "aws_dynamodb_table" "remote_state" {
  name           = var.aws_dynamodb_table_name
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = merge(
    {
      Name = "Minecraft State Locking table"
    },
    var.additional_tags,
  )
}
