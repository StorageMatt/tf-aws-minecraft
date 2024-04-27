resource "aws_instance" "ec2" {
  count                  = var.enable_on_demand ? 1 : 0
  ami                    = data.aws_ami.al2.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.server_security_group.id]
  key_name               = "${var.prefix_identifier}-${var.key_pair_name}"
  root_block_device {
    volume_size = var.instance_volume_size
    tags = merge(
      {},
      var.additional_tags,
    )
  }
  iam_instance_profile = aws_iam_instance_profile.minecraft_s3_access_profile.name
  user_data            = local.user_data
  tags = merge(
    {},
    var.additional_tags,
  )
}

resource "aws_eip" "elastic_ip" {
  count    = var.enable_on_demand ? 1 : 0
  instance = aws_instance.ec2[0].id
  domain   = "vpc"
  tags = merge(
    {},
    var.additional_tags,
  )
}
