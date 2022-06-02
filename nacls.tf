# acl_rule_in requester_private_to_accepter_private
resource "aws_network_acl_rule" "in_accepter_private_from_requester" {
  provider       = aws.accepter
  count          = length(data.aws_subnet.requester.*.cidr_block)
  network_acl_id = tolist(data.aws_network_acls.accepter_private.ids)[0]
  rule_number    = 1000 + var.serial + count.index
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

# acl_rule_out requester_private_to_accepter_private
resource "aws_network_acl_rule" "out_accepter_private_to_requester" {
  provider       = aws.accepter
  count          = length(data.aws_subnet.requester.*.cidr_block)
  network_acl_id = tolist(data.aws_network_acls.accepter_private.ids)[0]
  rule_number    = 1000 + var.serial + count.index
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

# acl_rule_in requester_private_to_accepter_public
resource "aws_network_acl_rule" "in_accepter_public_from_requester" {
  provider       = aws.accepter
  count          = var.in_accepter_public_from_requester ? length(data.aws_subnet.requester.*.cidr_block) : 0
  network_acl_id = tolist(data.aws_network_acls.accepter_public.ids)[0]
  rule_number    = 1000 + var.serial + count.index
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

# acl_rule_out requester_private_to_accepter_public
resource "aws_network_acl_rule" "out_accepter_public_to_requester" {
  provider       = aws.accepter
  count          = var.in_accepter_public_from_requester ? length(data.aws_subnet.requester.*.cidr_block) : 0
  network_acl_id = tolist(data.aws_network_acls.accepter_public.ids)[0]
  rule_number    = 1000 + var.serial + count.index
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

# acl_rule_in requester_private_to_accepter_secure
resource "aws_network_acl_rule" "in_accepter_secure_from_requester" {
  provider       = aws.accepter
  count          = var.in_accepter_secure_from_requester ? length(data.aws_subnet.requester.*.cidr_block) : 0
  network_acl_id = tolist(data.aws_network_acls.accepter_secure.ids)[0]
  rule_number    = 1000 + var.serial + count.index
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

# acl_rule_out requester_private_to_accepter_secure
resource "aws_network_acl_rule" "out_accepter_secure_to_requester" {
  provider       = aws.accepter
  count          = var.in_accepter_secure_from_requester ? length(data.aws_subnet.requester.*.cidr_block) : 0
  network_acl_id = tolist(data.aws_network_acls.accepter_secure.ids)[0]
  rule_number    = 1000 + var.serial + count.index
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

# acl_rule_in accepter_private_to_requester_private
resource "aws_network_acl_rule" "in_requester_private_from_accepter" {
  provider       = aws.requester
  count          = length(data.aws_subnet.accepter.*.cidr_block)
  network_acl_id = tolist(data.aws_network_acls.requester_private.ids)[0]
  rule_number    = 2000 + var.serial + count.index
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.accepter.*.cidr_block[count.index]
}

# acl_rule_out accepter_private_to_requester_private
resource "aws_network_acl_rule" "out_requester_private_to_accepter" {
  provider       = aws.requester
  count          = length(data.aws_subnet.accepter.*.cidr_block)
  network_acl_id = tolist(data.aws_network_acls.requester_private.ids)[0]
  rule_number    = 2000 + var.serial + count.index
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.accepter.*.cidr_block[count.index]
}

# acl_rule_in accepter_private_to_requester_public
resource "aws_network_acl_rule" "in_requester_public_from_accepter" {
  provider       = aws.requester
  count          = var.in_requester_public_from_accepter ? length(data.aws_subnet.accepter.*.cidr_block) : 0
  network_acl_id = tolist(data.aws_network_acls.requester_public.ids)[0]
  rule_number    = 2000 + var.serial + count.index
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.accepter.*.cidr_block[count.index]
}

# acl_rule_out accepter_private_to_requester_public
resource "aws_network_acl_rule" "out_requester_public_to_accepter" {
  provider       = aws.requester
  count          = var.in_requester_public_from_accepter ? length(data.aws_subnet.accepter.*.cidr_block) : 0
  network_acl_id = tolist(data.aws_network_acls.requester_public.ids)[0]
  rule_number    = 2000 + var.serial + count.index
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.accepter.*.cidr_block[count.index]
}

# acl_rule_in accepter_private_to_requester_secure
resource "aws_network_acl_rule" "in_requester_secure_from_accepter" {
  provider       = aws.requester
  count          = var.in_requester_secure_from_accepter ? length(data.aws_subnet.accepter.*.cidr_block) : 0
  network_acl_id = tolist(data.aws_network_acls.requester_secure.ids)[0]
  rule_number    = 2000 + var.serial + count.index
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.accepter.*.cidr_block[count.index]
}

# acl_rule_out accepter_private_to_requester_secure
resource "aws_network_acl_rule" "out_requester_secure_to_accepter" {
  provider       = aws.requester
  count          = var.in_requester_secure_from_accepter ? length(data.aws_subnet.accepter.*.cidr_block) : 0
  network_acl_id = tolist(data.aws_network_acls.requester_secure.ids)[0]
  rule_number    = 2000 + var.serial + count.index
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.accepter.*.cidr_block[count.index]
}
