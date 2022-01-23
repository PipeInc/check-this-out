# temp: deploy the code using local-exec
resource "null_resource" "deployment" {
  count = var.deploy ? 1 : 0

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "../deploy.sh ${local.bucket_name}"
  }

  depends_on = [
    module.s3-host-bucket
  ]
}
