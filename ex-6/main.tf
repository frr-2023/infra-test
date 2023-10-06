#Provider setup. Credentials defined with environment variables.
provider "aws" {
  region = "eu-west-1"
}

#Call the module that exists in the subfolder
module "iam_resources" {
  source = "./module_iam"
  users = var.users
}
#Output of the role_arn that we can assume
output "role_arn" {
  value = module.iam_resources.role_arn
}