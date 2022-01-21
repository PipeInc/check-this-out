variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS profile"
  type        = string
  default     = "default"
}

variable "aws_tags" {
  description = "AWS tags to be used in all resources"
  type        = map(string)
  default = {
    owner   = "MrKoopaKiller"
    project = "Check-this-out"
    git     = "https://github.com/MrKoopaKiller/"
  }
}
