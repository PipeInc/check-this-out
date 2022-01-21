output "website_url" {
  description = "Endpoint for the website"
  value       = "http://${module.s3-host-bucket.s3_bucket_website_endpoint}"
}
