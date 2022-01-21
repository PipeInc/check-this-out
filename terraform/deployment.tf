# temp: deploy the code using local-exec
resource "null_resource" "deployment" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "aws s3 sync --profile ${var.profile} ../html/ s3://${local.bucket_name}/"
  }

  depends_on = [
    module.s3-host-bucket
  ]
}
