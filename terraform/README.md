under construction

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.72.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3-host-bucket"></a> [s3-host-bucket](#module\_s3-host-bucket) | terraform-aws-modules/s3-bucket/aws | 2.13.0 |

## Resources

| Name | Type |
|------|------|
| [null_resource.deployment](https://registry.terraform.io/providers/hashicorp/null/3.1.0/docs/resources/resource) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/3.1.0/docs/resources/pet) | resource |
| [aws_canonical_user_id.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/canonical_user_id) | data source |
| [aws_iam_policy_document.allow_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_tags"></a> [aws\_tags](#input\_aws\_tags) | AWS tags to be used in all resources | `map(string)` | <pre>{<br>  "git": "https://github.com/MrKoopaKiller/",<br>  "owner": "MrKoopaKiller",<br>  "project": "Check-this-out"<br>}</pre> | no |
| <a name="input_deploy"></a> [deploy](#input\_deploy) | If true, terrafor will use null\_resource to run a local awscli command to deploy the website content in S3. | `bool` | `"false"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS profile | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_website_url"></a> [website\_url](#output\_website\_url) | Endpoint for the website |
<!-- END_TF_DOCS -->