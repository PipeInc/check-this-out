module "cdn" {
  count   = var.cdn ? 1 : 0
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "2.9.2"

  comment                       = "Hey World, Check-this-Out!"
  enabled                       = true
  is_ipv6_enabled               = true
  price_class                   = "PriceClass_All"
  retain_on_delete              = false
  wait_for_deployment           = false
  create_origin_access_identity = true
  default_root_object           = "index.html"
  origin_access_identities = {
    s3-host-bucket = "cloudfront_only"
  }

  origin = {
    s3-host-bucket = {
      domain_name = module.s3-host-bucket.s3_bucket_bucket_regional_domain_name
      s3_origin_config = {
        origin_access_identity = "s3-host-bucket"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3-host-bucket"
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = true
  }

  ordered_cache_behavior = [
    {
      path_pattern           = "/*"
      target_origin_id       = "s3-host-bucket"
      viewer_protocol_policy = "redirect-to-https"
      allowed_methods        = ["GET", "HEAD", "OPTIONS"]
      cached_methods         = ["GET", "HEAD"]
      compress               = true
      query_string           = true
    }
  ]
}
