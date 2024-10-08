locals {
  prefix         = (var.prefix_override != "" ? var.prefix_override : var.nuon_id)
  install_region = var.region
  tags           = merge({ nuon_id = var.nuon_id }, var.tags)
  nuon_id        = var.nuon_id
  cluster_name   = (var.prefix_override != "" ? var.prefix_override : var.nuon_id)
}

variable "prefix_override" {
  type        = string
  description = "Prefix used to name sandbox resources. Will default to the Nuon ID."
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "The ID of the AWS VPC to provision the sandbox in."
}

variable "subnet_ids" {
  type        = string
  description = "Comma separated list of subnet-ids to install the subnet in."
  default     = ""
}

variable "subnet_tag" {
  type        = string
  description = "key:value subnet tag to lookup subnets to install by"
  default     = ""
}

# These will be set by Nuon during the install provision process.

variable "nuon_id" {
  type        = string
  description = "An ID used to name resources. Defaults to the install ID. Will be set by Nuon during the install provision process."
}

variable "tags" {
  type        = map(any)
  description = "List of tags to add to all sandbox resources (that support tags). Used for taxonomic purposes. Will be set by Nuon during the install provision process."
}

variable "region" {
  type        = string
  description = "The AWS region to provision the sandbox in. Will be set by Nuon during the install provision process."
}

// NOTE: if you would like to create an internal load balancer, with TLS, you will have to use the public domain.
variable "internal_root_domain" {
  type        = string
  description = "The internal root domain of the sandbox. Will be set by Nuon during the install provision process."
}

variable "public_root_domain" {
  type        = string
  description = "The public root domain of the sandbox. Will be set by Nuon during the install provision process."
}

variable "private_subnet_ids" {
  type        = string
  default     = ""
  description = "Comma-separated string of IDs of the subnets to create private resources in."
}

variable "public_subnet_ids" {
  type        = string
  default     = ""
  description = "Comma-separated string of IDs of the subnets to create public resources in."
}

variable "runner_install_role" {
  type        = string
  description = "The role that is used to install the runner, and should be granted access."
}
