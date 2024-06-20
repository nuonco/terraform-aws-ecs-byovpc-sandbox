output "runner" {
  value = {
    runner_iam_role_arn  = module.runner_iam_role.iam_role_arn
    odr_iam_role_arn     = module.odr_iam_role.iam_role_arn
    install_iam_role_arn = module.runner_install_iam_role.iam_role_arn
  }
  description = "A map of runner attributes: runner_iam_role_arn, odr_iam_role_arn, install_iam_role_arn"
}

output "ecs_cluster" {
  value = {
    arn  = module.ecs_cluster.cluster_arn,
    id   = module.ecs_cluster.cluster_id,
    name = module.ecs_cluster.cluster_name,
  }
  description = "A map of ecs_cluster attributes: arn, id, name."
}

output "vpc" {
  // NOTE: these are declared here -
  // https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest?tab=outputs
  value = {
    name = lookup(data.aws_vpc.main.tags, "Name", "")
    id   = data.aws_vpc.main.id
    cidr = data.aws_vpc.main.cidr_block
    azs  = data.aws_availability_zones.available.zone_ids

    private_subnet_cidr_blocks = [for s in data.aws_subnet.private : s.cidr_block]
    private_subnet_ids         = local.private_subnet_ids

    public_subnet_cidr_blocks = [for s in data.aws_subnet.public : s.cidr_block]
    public_subnet_ids         = local.public_subnet_ids

    default_security_group_id  = aws_security_group.runner.id
    default_security_group_arn = aws_security_group.runner.arn
  }
  description = "A map of vpc attributes: name, id, cidr, azs, private_subnet_cidr_blocks, private_subnet_ids, public_subnet_cidr_blocks, public_subnet_ids, default_security_group_id, default_security_group_arn."
}

output "account" {
  value = {
    id     = data.aws_caller_identity.current.account_id
    region = var.region
  }
  description = "A map of AWS account attributes: id, region"
}

output "ecr" {
  value = {
    repository_url  = module.ecr.repository_url
    repository_arn  = module.ecr.repository_arn
    repository_name = local.prefix
    registry_id     = module.ecr.repository_registry_id
    registry_url    = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
  }
  description = "A map of ECR attributes: repository_url, repository_arn, repository_name, registry_id, registry_url."
}

output "public_domain" {
  value = {
    nameservers = aws_route53_zone.public.name_servers
    name        = aws_route53_zone.public.name
    zone_id     = aws_route53_zone.public.id
  }
  description = "A map of public Route53 zone attributes: nameservers, name, zone_id."
}

output "internal_domain" {
  value = {
    nameservers = aws_route53_zone.internal.name_servers
    name        = aws_route53_zone.internal.name
    zone_id     = aws_route53_zone.internal.id
  }
  description = "A map of internal Route53 zone attributes: nameservers, name, zone_id."
}
