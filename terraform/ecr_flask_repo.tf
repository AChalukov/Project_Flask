module "Create_ECR_for_flask_app" {
  source = "./modules/ECR"
  ecr_name = "flask"
  image_tag_mutability = "IMMUTABLE"
  scan_on_push = "true"
}