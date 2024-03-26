# terraform-aws-ecs-byovpc-sandbox

AWS ECS BYOVPC sandbox for Nuon apps.

## Usage

This module can be used via the [aws-ecs-byovpc](github.com/nuonco/sandboxes/aws-ecs-byovpc) project in [nuonco/sandboxes](github.com/nuonco/sandboxes).

```hcl
resource "nuon_app" "my_byovpc_app" {
  name = "my_byovpc_app"
}

resource "nuon_app_input" "vpc_id" {
  app_id = nuon_app.my_byovpc_app.id

  input {
    name = "vpc_id"
    description = "The VPC to install the app in"
    sensitive = false
    display_name = "VPC ID"
    required = true
  }
}

resource "nuon_app_sandbox" "main" {
  app_id            = nuon_app.my_byovpc_app.id
  terraform_version = "v1.6.3"
  public_repo = {
    repo      = "nuonco/sandboxes"
    branch    = "main"
    directory = "aws-ecs-byovpc"
  }
}
```
