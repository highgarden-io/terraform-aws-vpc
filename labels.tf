module "labels" {
  source  = "highgarden-io/standard/labels"
  version = "1.1.0"
  # insert the 5 required variables here

  layer            = var.layer
  namespace        = var.namespace
  name             = var.name
  region           = var.region
  stage            = var.stage
  component        = var.component
  zone             = var.zone
  managed_by_ref   = var.managed_by_ref
  org_tld          = var.org_tld
  org_short        = var.org_short
  org              = var.org
  managed_by       = var.managed_by
  id_label_keyname = var.id_label_keyname
  id_label_enabled = var.id_label_enabled
}

variable "org" {
  type        = string
  description = "The Organization Name"
  default     = "highgarden"
}
variable "org_short" {
  type        = string
  description = "Short Organization Name used for naming resources."
  default     = "h8n"
  validation {
    condition     = length(var.org_short) <= 6 && length(var.org_short) >= 2
    error_message = "Organization Short name must be between 2 and 6 characters, as it is part of ID 63 char limit."
  }
}
variable "org_tld" {
  type        = string
  description = "Organization TLD used to generate standard labels keys."
  default     = "io"
}

variable "id_label_enabled" {
  type        = bool
  description = "Extra Label with the ID Value (e.g 'Name' for AWS)"
  default     = true
}

variable "id_label_keyname" {
  type        = string
  description = "Extra Label with the ID Value (e.g 'Name' for AWS)"
  default     = "Name"
}

variable "layer" {
  type        = string
  description = "Infrastructure layer of the resources, used to generate resource ID."
  validation {
    condition     = length(var.layer) <= 6 && length(var.layer) >= 2
    error_message = "Infrastructure Layer name must be between 2 and 6 characters, as it is part of ID 63 char limit."
  }
}

variable "namespace" {
  type        = string
  description = "Namespace of generate resources, used to group resources of a team/sub-organization."
  default     = "main"
  validation {
    condition     = length(var.namespace) <= 6 && length(var.namespace) >= 2
    error_message = "Namespace must be between 2 and 6 characters, as it is part of ID 63 char limit."
  }
}
variable "stage" {
  type        = string
  description = "Stage of the resources, such as dev, test, prod, etc."
  validation {
    condition     = length(var.stage) <= 6 && length(var.stage) >= 2
    error_message = "Stage name must be between 2 and 6 characters, as it is part of ID 63 char limit."
  }
}
variable "name" {
  type        = string
  description = "Name of the resources, used to generate resource ID."
  validation {
    condition     = length(var.name) <= 6
    error_message = "Name must be between 2 and 6 characters, as it is part of ID 63 char limit."
  }
}
variable "component" {
  type        = string
  description = "Sub-component of the resources, used to generate resource ID. (optional)"
  default     = ""
}
variable "region" {
  type        = string
  description = "Region of the resources, used to generate resource ID."
}

variable "zone" {
  type        = string
  description = "Zone of the resources if applicable. (optional)"
  default     = ""
}

variable "managed_by" {
  type        = string
  description = "Name of the component that manages the resources. ( default to 'Terraform', possible values can be other IAC Tools if not managed by Terraform)"
  default     = "terraform"
}

variable "managed_by_ref" {
  type        = string
  description = "Reference of the location of the component that manages the resources. (Repo / Terraform State Path)"
}