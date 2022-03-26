#module "labels" {
#  source  = "highgarden-io/standard/labels"
#  version = "1.1.0"
#  # insert the 5 required variables here
#  name = "vpc"
#  layer = "fndl"
#  region = "ew2"
#  stage = "prod"
#  managed_by_ref = "terragrunt/vpc"
#  id_label_enabled = false
#}
#
#provider "aws" {
#  default_tags {
#    tags = module.labels.labels
#  }
#}