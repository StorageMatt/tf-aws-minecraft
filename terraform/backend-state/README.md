# REMOTE STATE

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.46.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.remote_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_kms_key.remote_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.remote_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.remote_state_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.remote_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.remote_state_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.bucket-remote_state_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.remote_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_ownership_controls.remote_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.remote_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.remote_state_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.remote_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.remote_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [random_id.remote_state](https://registry.terraform.io/providers/hashicorp/random/3.6.1/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional resource tags | `map(string)` | `{}` | no |
| <a name="input_aws_credentials_profile"></a> [aws\_credentials\_profile](#input\_aws\_credentials\_profile) | High level profile name that the terraform uses for aws access to create new role/policy/user for minecraft server deployment | `string` | `"default"` | no |
| <a name="input_aws_dynamodb_table_name"></a> [aws\_dynamodb\_table\_name](#input\_aws\_dynamodb\_table\_name) | Name for the backend state locking table | `string` | `"minecraft-tflock"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region of aws to use | `string` | `"eu-west-2"` | no |
| <a name="input_aws_s3_state_bucket_name"></a> [aws\_s3\_state\_bucket\_name](#input\_aws\_s3\_state\_bucket\_name) | Name for the backend state bucket | `string` | `"minecraft-tfstate"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_remote_state_bucket_name"></a> [remote\_state\_bucket\_name](#output\_remote\_state\_bucket\_name) | Name of the created bucket for backend remote state |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable -->
