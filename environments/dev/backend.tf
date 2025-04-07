terraform {
  backend "s3" {
    bucket  = "ror-tfstate-task"
    profile = "default"
    region  = "ap-south-1"
    key     = "dev"
  }
}
