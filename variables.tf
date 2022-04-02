variable "create_s3_gateway_endpoint" {
  type        = bool
  description = "Create S3 VPC Gateway Endpoint"
  default     = true
}

variable "create_dynamodb_gateway_endpoint" {
  type        = bool
  description = "Create Dynamo VPC Gateway Endpoint"
  default     = true
}