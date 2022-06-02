variable "accepter_owner_id" {
  type        = string
  description = "Account ID of accepter."
}

variable "accepter_vpc_id" {
  type        = string
  description = "VPC ID of accepter."
}

variable "accepter_region" {
  type        = string
  description = "Region of acccepter."
}

variable "requester_owner_id" {
  type        = string
  description = "Account ID of requester."
}

variable "requester_vpc_id" {
  type        = string
  description = "VPC ID of requester."
}

variable "requester_region" {
  type        = string
  description = "Region of requester."
}

variable "peering_subnet" {
  type        = string
  default     = "private"
  description = "Name of the requester subnet tag to be peered."
}

variable "serial" {
  type        = number
  default     = 0
  description = "Number of this peering, distinct from others, to avoid conflict with NACL rule number."
}

variable "in_requester_public_from_accepter" {
  type        = bool
  default     = false
  description = "Wether configure routing and NACL between accepter_private and requester_public subnets."
}

variable "in_requester_secure_from_accepter" {
  type        = bool
  default     = false
  description = "Wether configure routing and NACL between accepter_private and requester_secure subnets."
}

variable "in_accepter_public_from_requester" {
  type        = bool
  default     = false
  description = "Wether configure routing and NACL between requester_private and accepter_public subnets."
}

variable "in_accepter_secure_from_requester" {
  type        = bool
  default     = false
  description = "Wether configure routing and NACL between requester_private and accepter_secure subnets."
}
