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

Terraform will create all necessary resources on AWS, the output is the URL for the provisioned website.


## Continous Integration
For **C**ontinous **I**ntegration and quality control the [pre-commit](https://pre-commit.com) with a set of hooks are being used.

The pre-commit hooks will make use of the standard linter, formatter and security checks to guarantee the quality of the code.

The file `.pre-commit-config.yaml` is the configurationfile for pre-commit stuffs and the file `.tflint.hcl` are the rules for the [tflint plugin](https://github.com/terraform-linters/tflint).

**Hooks**

- [terraform-fmt](https://github.com/antonbabenko/pre-commit-terraform#terraform_fmt): Reformat all Terraform configuration files to a canonical format
- [terraform-validate](https://github.com/antonbabenko/pre-commit-terraform#terraform_validate): Validates all Terraform configuration files.
- [tflint](https://github.com/antonbabenko/pre-commit-terraform#terraform_tflint): Validates all Terraform configuration files with [TFLint](https://github.com/terraform-linters/tflint)
- [terraform-docs-go](https://github.com/terraform-docs/terraform-docs): Generate documentation from Terraform modules in markdow format.
- [terraform_tfsec](git://github.com/antonbabenko/pre-commit-terraform): Perform static analysis of terraform templates to spot potential security issues using [TFSec](https://github.com/aquasecurity/tfsec).

The idea here is run all tests inside a docker container, the code will be copied during the build and tests will be executed. If no errors happens the container will build sucessfully, otherwise it will fail meaning that the tests failed.

The `Dockerbuild` file contains everything necessary to run. It could be implemented in CI step in pipeline.


## TODO:
- write plan to scale (terraform?)

## Enhancements
- review deployment process (terraform should deploy or not?)

- Enable s3 logging web traffic
- Enable s3 Object versioning (if needed)
- Enable s3 object encryption
