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
  user_data = templatefile("${path.module}/templates/mc-init.tpl", {
    instance_hostname                = var.instance_hostname
    minecraft_server_memory          = var.minecraft_server_memory
    minecraft_data_bucket_id         = aws_s3_bucket.minecraft_data.id
    minecraft_world_backup_object    = aws_s3_object.world_data.id
    minecraft_settings_backup_object = aws_s3_object.settings.id
    minecraft_server_whitelist       = var.minecraft_server_whitelist
    minecraft_server_rcon            = var.minecraft_server_rcon
    minecraft_server_rcon_pass       = var.minecraft_server_rcon_pass
    minecraft_server_max_players     = var.minecraft_server_max_players
    minecraft_server_hardcore_mode   = var.minecraft_server_hardcore_mode
    minecraft_server_motd            = var.minecraft_server_motd
    minecraft_version_download_link  = var.minecraft_version_selector["1.18.2"]
    }
  )
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
