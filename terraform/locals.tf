locals{
  user_data = templatefile("${path.module}/templates/mc-init.sh.tpl", {
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
}