data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.13.0"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [data.aws_security_group.default.id]


  endpoints = {
    s3 = {
      create          = var.create_s3_gateway_endpoint
      service         = "s3"
      tags            = { Name = "${module.vpc.name}-s3" }
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.intra_route_table_ids, module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
    },
    dynamodb = {
      create          = var.create_dynamodb_gateway_endpoint
      service         = "dynamodb"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.intra_route_table_ids, module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
      policy          = data.aws_iam_policy_document.dynamodb_endpoint_policy.json
      tags            = { Name = "${module.vpc.name}-dynamodb" }
    },
    #    ssm = {
    #      service             = "ssm"
    #      private_dns_enabled = true
    #      subnet_ids          = slice(module.vpc.private_subnets, 0, length(var.azs))
    #      security_group_ids  = [aws_security_group.vpc_tls_internal.id]
    #      tags    = { Name = "${module.vpc.name}-ssm" }
    #    },
    #    ssmmessages = {
    #      service             = "ssmmessages"
    #      private_dns_enabled = true
    #      subnet_ids          = slice(module.vpc.private_subnets, 0, length(var.azs))
    #      security_group_ids  = [aws_security_group.vpc_tls_internal.id]
    #      tags    = { Name = "${module.vpc.name}-ssmmessages" }
    #    }
  }
}

data "aws_iam_policy_document" "dynamodb_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["dynamodb:*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:sourceVpce"

      values = [module.vpc.vpc_id]
    }
  }
}

