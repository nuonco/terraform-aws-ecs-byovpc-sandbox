module "ecs_cluster" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.11.0"

  cluster_name = local.prefix

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
        base   = 20
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  tags = local.tags
}
