# Check-this-Out!

## AWS Deployment using terraform
### Pre requitsites

- [AWS Account](https://aws.amazon.com/resources/create-account/)
- [AWS Access Key](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/)
- [AWSCLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) - configure to use default profile (See [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-config))
- [Terraform 1.1.4+](https://www.terraform.io/downloads)



### Required AWS resources

The terraform code in this repo will create a couple of resources in your AWS account.

With all tools installed/configure let's start by cloning this repo and initializing terraform:

```bash
$ cd terraform/ # Change working directory to ./terraform

$ terraform init # Terraform will initialize a local state file and download all required modules.
```

The next step is check all required changes, [`terraform plan`](https://www.terraform.io/cli/commands/plan) creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. Reads the current state file, compare with the current configuration and propose a set of changes to make in remote objects.

```bash
terraform plan -out terraform.plan
```

This will create the file `terraform.plan` with all necessary changes.

If you are satisfied with the changes, use the [`terraform apply`](https://www.terraform.io/cli/commands/apply) to apply the changes proposed by the plan in the previous step.

> :warning: **Keep in mind**: charges could be applied in your AWS account. Check here for the [AWS Free Tier](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-free-tier.html)

```bash
terraform apply "terraform.plan"
```

After 
## TODO:
- Use terraform-docs to create tf docs
- use pre-commit
- write plan to scale (terraform?)

## Enhancements
If necessary:
- Enable s3 logging web traffic 
- Enable s3 Object versioning (if needed)
- Enable s3 object encryption