module "vpc" {
  source      = "../modules/vpc"
  cidr_block  = var.vpc_cidr
  environment = var.environment
}

module "eks" {
  source          = "../modules/eks"
  cluster_name    = "${var.environment}-eks"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "rds" {
  source          = "../modules/rds"
  db_name         = "appdb"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "ecr" {
  source          = "../modules/ecr"
  repository_name = "${var.environment}-app"
}

module "observability" {
  source = "../modules/observability"

  cluster_name = module.eks.cluster_name
  region       = var.region
  vpc_id       = module.vpc.vpc_id
  alarm_email  = "sample@devops.com"
}