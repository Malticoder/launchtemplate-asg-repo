
provider "aws" {
  region = "us-east-1"
}

locals {
  ami_id         = "ami-08a6efd148b1f7504"
  instance_type  = "t2.micro"
  subnet_ids     = ["subnet-04ed4c9b0574d8256", "subnet-0dcff7dc96b3b6887"]
  environment    = "dev"
}

module "launch_template" {
  source        = "../modules/launch_template"
  ami_id        = local.ami_id
  instance_type = local.instance_type
  environment   = local.environment
}

module "asg" {
  source              = "../modules/asg"
  launch_template_id  = module.launch_template.launch_template_id
  vpc_zone_identifier = local.subnet_ids
  environment         = local.environment
}
