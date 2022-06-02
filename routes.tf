resource "aws_route" "accepter_private" {
  provider = aws.accepter
  count    = length(distinct(data.aws_route_table.accepter_private.*.route_table_id))
  route_table_id = element(
    distinct(data.aws_route_table.accepter_private.*.route_table_id),
    count.index
  )
  destination_cidr_block    = data.aws_vpc.requester.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter.id
}

resource "aws_route" "accepter_public" {
  provider = aws.accepter
  count    = var.in_requester_public_from_accepter ? length(distinct(data.aws_route_table.accepter_public.*.route_table_id)) : 0
  route_table_id = element(
    distinct(data.aws_route_table.accepter_public.*.route_table_id),
    count.index
  )
  destination_cidr_block    = data.aws_vpc.requester.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter.id
}

resource "aws_route" "accepter_secure" {
  provider = aws.accepter
  count    = var.in_requester_secure_from_accepter ? length(distinct(data.aws_route_table.accepter_secure.*.route_table_id)) : 0
  route_table_id = element(
    distinct(data.aws_route_table.accepter_secure.*.route_table_id),
    count.index
  )
  destination_cidr_block    = data.aws_vpc.requester.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter.id
}

resource "aws_route" "requester_private" {
  provider = aws.requester
  count = length(distinct(data.aws_route_table.requester_private.*.route_table_id))
  route_table_id = element(
    distinct(data.aws_route_table.requester_private.*.route_table_id),
    count.index
  )
  destination_cidr_block    = data.aws_vpc.accepter.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
}

resource "aws_route" "requester_public" {
  provider = aws.requester
  count = var.in_accepter_public_from_requester ? length(distinct(data.aws_route_table.requester_public.*.route_table_id)) : 0
  route_table_id = element(
    distinct(data.aws_route_table.requester_public.*.route_table_id),
    count.index
  )
  destination_cidr_block    = data.aws_vpc.accepter.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
}

resource "aws_route" "requester_secure" {
  provider = aws.requester
  count = var.in_accepter_secure_from_requester ? length(distinct(data.aws_route_table.requester_secure.*.route_table_id)) : 0
  route_table_id = element(
    distinct(data.aws_route_table.requester_secure.*.route_table_id),
    count.index
  )
  destination_cidr_block    = data.aws_vpc.accepter.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
}
