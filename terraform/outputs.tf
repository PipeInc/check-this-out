output "website_url" {
  description = "Endpoint for the website"
  value       = "http://${module.s3-host-bucket.s3_bucket_website_endpoint}"
}

output "cdn_url" {
  description = "CDN endpoint for the website"
  value       = var.cdn == true ? module.cdn[0].cloudfront_distribution_domain_name : null
}
