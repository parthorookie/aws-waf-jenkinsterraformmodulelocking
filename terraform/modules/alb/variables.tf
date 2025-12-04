variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = string
}

variable "waf_arn" {
  type = string
}

variable "environment" {
  type = string
}