variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "prd"  # Optional: Set a sensible default
}

module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
}

module "networking" {
  source         = "./modules/networking"
  vpc_id         = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  environment    = var.environment  # Pass for route table/IGW/NAT naming
}

module "security_groups" {
  source      = "./modules/security-groups"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment  # Pass for SG naming/tagging
}

module "waf" {
  source      = "./modules/waf"
  environment = var.environment  # Pass for ACL naming/metrics
}

module "alb" {
  source          = "./modules/alb"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = module.security_groups.alb_sg_id
  waf_arn         = module.waf.waf_arn
  environment     = var.environment  # Pass for ALB naming/tagging
}