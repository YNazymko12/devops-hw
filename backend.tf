terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-goit-lesson5"
    key    = "terraform.tfstate"
    region = "eu-central-1"  

    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}