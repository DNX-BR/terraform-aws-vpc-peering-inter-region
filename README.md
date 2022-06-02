# terraform-aws-vpc-peering-inter-region

[![Lint Status](https://github.com/DNXLabs/terraform-aws-vpc-peering-inter-region/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-vpc-peering-inter-region/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-vpc-peering-inter-region)](https://github.com/DNXLabs/terraform-aws-vpc-peering-inter-region/blob/master/LICENSE)

This terraform module provide resources to manage Virtual Private Cloud (VPC) peering connections inter regions. A VPC peering connection is a networking connection between two VPCs that enables you to route traffic between them using private IPv4 addresses or IPv6 addresses.

The following resources will be created:

 - A VPC requester - VPC that sends a request to the owner of the accepter VPC to create the VPC peering connection
 - A VPC Accepter - VPC  that accepts the VPC peering connection request to activate the VPC peering connection.
 - Route tables - that contains a set of rules, called routes, that are used to determine where network traffic from your subnet or gateway is directed.
 - Network Access Control List (NACL) - that provides a rule-based tool for controlling network traffic ingress and egress at the protocol and subnet level.
     - in_accepter_private_from_requester
     - out_accepter_private_to_requester
     - in_accepter_public_from_requester
     - out_accepter_public_to_requester
     - in_accepter_secure_from_requester
     - out_accepter_secure_to_requester
     - in_requester_private_from_accepter
     - out_requester_private_to_accepter
     - in_requester_public_from_accepter
     - out_requester_public_to_accepter
     - in_requester_secure_from_accepter
     - out_requester_secure_to_accepter

## Usage

```hcl
module "vpc_peering" {
  source = "git::https://github.com/DNX-BR/terraform-aws-vpc-peering-inter-region?ref=0.0.2"

  providers = {
    aws.accepter  = aws.accepter
    aws.requester = aws.requester
  }

  # "serial" must be different for each peering, start at 100 and going on 100 by 100
  serial             = local.workspace.vpc_peering.index
  peering_subnet     = "private"
  requester_region   = local.workspace.aws_region
  requester_owner_id = local.workspace.aws_account_id
  requester_vpc_id   = data.aws_vpc.requester.id
  accepter_region    = local.workspace.vpc_peering.accepter_region
  accepter_owner_id  = local.workspace.vpc_peering.accepter_account_id
  accepter_vpc_id    = data.aws_vpc.accepter.id

  # Wether configure routing and NACL to allow access between subnets
  in_requester_public_from_accepter = local.workspace.vpc_peering.routing.accepter_private_and_requester_public
  in_requester_secure_from_accepter = local.workspace.vpc_peering.routing.accepter_private_and_requester_secure
  in_accepter_public_from_requester = local.workspace.vpc_peering.routing.requester_private_and_accepter_public
  in_accepter_secure_from_requester = local.workspace.vpc_peering.routing.requester_private_and_accepter_secure
}
```

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.accepter"></a> [aws.accepter](#provider\_aws.accepter) | n/a |
| <a name="provider_aws.requester"></a> [aws.requester](#provider\_aws.requester) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_network_acl_rule.in_accepter_private_from_requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.in_accepter_public_from_requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.in_accepter_secure_from_requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.in_requester_private_from_accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.in_requester_public_from_accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.in_requester_secure_from_accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.out_accepter_private_to_requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.out_accepter_public_to_requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.out_accepter_secure_to_requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.out_requester_private_to_accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.out_requester_public_to_accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.out_requester_secure_to_accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route.accepter_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.accepter_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.accepter_secure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.requester_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.requester_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.requester_secure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc_peering_connection.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_accepter.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [aws_vpc_peering_connection_options.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) | resource |
| [aws_vpc_peering_connection_options.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) | resource |
| [aws_network_acls.accepter_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_acls) | data source |
| [aws_network_acls.accepter_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_acls) | data source |
| [aws_network_acls.accepter_secure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_acls) | data source |
| [aws_network_acls.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_acls) | data source |
| [aws_network_acls.requester_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_acls) | data source |
| [aws_network_acls.requester_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_acls) | data source |
| [aws_network_acls.requester_secure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_acls) | data source |
| [aws_route_table.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_route_table.accepter_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_route_table.accepter_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_route_table.accepter_secure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_route_table.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_route_table.requester_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_route_table.requester_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_route_table.requester_secure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_subnet.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.accepter_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.accepter_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.accepter_secure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.requester_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.requester_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.requester_secure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accepter_owner_id"></a> [accepter\_owner\_id](#input\_accepter\_owner\_id) | Account ID of accepter. | `string` | n/a | yes |
| <a name="input_accepter_region"></a> [accepter\_region](#input\_accepter\_region) | Region of acccepter. | `string` | n/a | yes |
| <a name="input_accepter_vpc_id"></a> [accepter\_vpc\_id](#input\_accepter\_vpc\_id) | VPC ID of accepter. | `string` | n/a | yes |
| <a name="input_in_accepter_public_from_requester"></a> [in\_accepter\_public\_from\_requester](#input\_in\_accepter\_public\_from\_requester) | Wether configure routing and NACL between requester\_private and accepter\_public subnets. | `bool` | `false` | no |
| <a name="input_in_accepter_secure_from_requester"></a> [in\_accepter\_secure\_from\_requester](#input\_in\_accepter\_secure\_from\_requester) | Wether configure routing and NACL between requester\_private and accepter\_secure subnets. | `bool` | `false` | no |
| <a name="input_in_requester_public_from_accepter"></a> [in\_requester\_public\_from\_accepter](#input\_in\_requester\_public\_from\_accepter) | Wether configure routing and NACL between accepter\_private and requester\_public subnets. | `bool` | `false` | no |
| <a name="input_in_requester_secure_from_accepter"></a> [in\_requester\_secure\_from\_accepter](#input\_in\_requester\_secure\_from\_accepter) | Wether configure routing and NACL between accepter\_private and requester\_secure subnets. | `bool` | `false` | no |
| <a name="input_peering_subnet"></a> [peering\_subnet](#input\_peering\_subnet) | Name of the requester subnet tag to be peered. | `string` | `"private"` | no |
| <a name="input_requester_owner_id"></a> [requester\_owner\_id](#input\_requester\_owner\_id) | Account ID of requester. | `string` | n/a | yes |
| <a name="input_requester_region"></a> [requester\_region](#input\_requester\_region) | Region of requester. | `string` | n/a | yes |
| <a name="input_requester_vpc_id"></a> [requester\_vpc\_id](#input\_requester\_vpc\_id) | VPC ID of requester. | `string` | n/a | yes |
| <a name="input_serial"></a> [serial](#input\_serial) | Number of this peering, distinct from others, to avoid conflict with NACL rule number. | `number` | `0` | no |

## Outputs

No outputs.

<!--- END_TF_DOCS --->

## Author

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-vpc-peering-inter-region/blob/master/LICENSE) for full details.
