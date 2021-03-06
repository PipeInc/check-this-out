# Check-this-Out!

This is an example of how to host and deploy a simple static website in AWS using [Amazon S3](https://aws.amazon.com/s3/) and [Amazon Cloudfront](https://aws.amazon.com/cloudfront/) (optional).
The [terraform](https://www.terraform.io) is used for create everything necessary in AWS.

This is a fully scalable example for a static website: Nothing complicated or using over engineering, just simple as it should be.

**Why S3?**
- Amazon is responsible for serving the content.
- Scale up automatically. No additional configuration or resources are needed.
- High availability. Amazon guarantees 99.99% availability of S3.
- Fast content serving using Cloudfront CDN.

## TL;DR

The website could be deployed using the following commands:
```bash
git clone https://github.com/PipeInc/check-this-out.git
cd terraform/
terraform init
terraform plan -out terraform.plan
terraform apply "terraform.plan"
```
The output should be like:
```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
website_url = "http://<my-bucket>-website.s3-website-us-east-1.amazonaws.com"
```
Use the url to access the website. :rocket:

## Pre requitsites

- [AWS Account](https://aws.amazon.com/resources/create-account/)
- [AWS Access Key](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/)
- [AWSCLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) - configure to use default profile (See [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-config))
- [Terraform 1.1.4+](https://www.terraform.io/downloads)


## Terraform deployment

The terraform is the responsible to create the resources in the AWS, you can choose to use terraform to deploy your code or not and also to create the cloudfront distribution or not. By default terraform deploys the code but not the cloudfront. Check the [Conditional flags](#conditional-flags) for more information.

With all tools installed/configure let's start by cloning this repo and initializing terraform:

```bash
$ cd terraform/ # Change working directory to ./terraform

$ terraform init # Terraform will initialize a local state file and download all required modules.
```

The next step is check all required changes, [`terraform plan`](https://www.terraform.io/cli/commands/plan) creates an execution plan, which lets you preview the upcoming changes. Reads the current state file and compare with the current configuration to propose a set of changes to make in remote objects.

```bash
terraform plan -out terraform.plan
```

This creates the file `terraform.plan` with all necessary changes.

If you are satisfied with the changes, use the [`terraform apply`](https://www.terraform.io/cli/commands/apply) to apply.

> :warning: **Keep in mind**: charges could be applied in your AWS account. Check the [AWS Free Tier](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-free-tier.html) page for more information.

```bash
terraform apply "terraform.plan"
```

Terraform creates all necessary resources on AWS and give you the website url.

### Conditional flags

If necessary you can use the flags `-var=deploy=true|false` and `-var=cdn=true|false` in terraform `plan` and `apply`t command. It allows terraform deploy your code to S3 and also enable the Amazon Cloufront CDN on your website. Check the README file into `terraform` directory for details.

**Examples:**

```bash 
# Deploy and create cloudfront:
terraform apply "terraform.plan" -var=cdn=true

# Create the AWS resources but not deploy the code:
terraform apply "terraform.plan" -var=deploy=false 

# Or you can combine all: Create cloudfront but nor deploy the code:
terraform apply "terraform.plan" -var=cdn=true -var=deploy=false
```
## Continous Integration
For **C**ontinous **I**ntegration and quality control the [pre-commit](https://pre-commit.com) with a set of hooks are being used.

The pre-commit hooks will make use of the standard linter, formatter and security checks to guarantee the quality of the code.

The file `.pre-commit-config.yaml` is the configuration file for pre-commit stuffs and the file `.tflint.hcl` are the rules for the [tflint plugin](https://github.com/terraform-linters/tflint).

**Hooks**

- [terraform-fmt](https://github.com/antonbabenko/pre-commit-terraform#terraform_fmt): Reformat all Terraform configuration files to a canonical format
- [terraform-validate](https://github.com/antonbabenko/pre-commit-terraform#terraform_validate): Validates all Terraform configuration files.
- [tflint](https://github.com/antonbabenko/pre-commit-terraform#terraform_tflint): Validates all Terraform configuration files with [TFLint](https://github.com/terraform-linters/tflint)
- [terraform-docs-go](https://github.com/terraform-docs/terraform-docs): Generate documentation from Terraform modules in markdow format.
- [terraform_tfsec](git://github.com/antonbabenko/pre-commit-terraform): Perform static analysis of terraform templates to spot potential security issues using [TFSec](https://github.com/aquasecurity/tfsec).

The idea here is run all tests inside a docker container, the code will be copied and tested during the build process. If docker build complete successfully the code are good, if it fails then something should be reviewed.

The `Dockerbuild` file contains everything necessary to run. It could be implemented in CI step in pipeline.

## Enhancements
- Enable s3 logging web traffic;
- Enable s3 object versioning;
- Enable s3 object encryption;
- CI/CD code{commit,build,pipeline} / jenkins

## Sample website
The sample website used in this repo is from [Free-CSS](https://www.free-css.com/free-css-templates/page270/univers).

>*All of the free CSS templates, layouts & menus that are featured within [Free CSS](https://www.free-css.com/help-and-support/copyright-notice#terms-of-use) are distributed under some form of GNU/GPL, Creative Commons, author specific or public domain end user licence.*
