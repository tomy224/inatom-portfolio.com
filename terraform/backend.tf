terraform {
  backend "s3" {
    bucket = "inatom-portfolio-terraform-state"
    key    = "portfolio/terraform.tfstate"
    region = "ap-northeast-1"
  }
}