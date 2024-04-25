locals {
  vpc_id                    = var.vpc_id
  subnets_private_tag_key   = "visibility"
  subnets_private_tag_value = "private"
  subnets_public_tag_key    = "visibility"
  subnets_public_tag_value  = "public"

  private_subnet_ids = length(var.private_subnet_ids) > 0 ? split(",", replace(replace(var.private_subnet_ids, " ", ""), "\n", "")) : data.aws_subnets.private.ids
  public_subnet_ids  = length(var.public_subnet_ids) > 0 ? split(",", replace(replace(var.public_subnet_ids, " ", ""), "\n", "")) : data.aws_subnets.public.ids
}


data "aws_vpc" "main" {
  id = local.vpc_id
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = local.vpc_id
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }

  filter {
    name   = "tag:${local.subnets_private_tag_key}"
    values = [local.subnets_private_tag_value]
  }
}

data "aws_subnet" "private" {
  for_each = toset(local.private_subnet_ids)
  id       = each.value
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }

  filter {
    name   = "tag:${local.subnets_public_tag_key}"
    values = [local.subnets_public_tag_value]
  }
}

data "aws_subnet" "public" {
  for_each = toset(local.public_subnet_ids)
  id       = each.value
}
