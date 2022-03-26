resource "aws_security_group" "vpc_http_internal" {
  name_prefix = "${module.vpc.name}-http-internal"
  description = "Allow TLS inbound traffic from VPC CIDRs (including secondary CIDRs)"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = concat([module.vpc.vpc_cidr_block], module.vpc.vpc_secondary_cidr_blocks)
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = concat([module.vpc.vpc_cidr_block], module.vpc.vpc_secondary_cidr_blocks)
  }

  tags = {
    Name = "${module.vpc.name}-tls-internal"
  }
}

resource "aws_security_group" "vpc_tls_internal" {
  name_prefix = "${module.vpc.name}-tls-internal"
  description = "Allow TLS inbound traffic from VPC CIDRs (including secondary CIDRs)"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = concat([module.vpc.vpc_cidr_block], module.vpc.vpc_secondary_cidr_blocks)
  }

  tags = {
    Name = "${module.vpc.name}-tls-internal"
  }
}

resource "aws_security_group" "vpc_tls_public" {
  name_prefix = "${module.vpc.name}-tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${module.vpc.name}-tls-internal"
  }
}