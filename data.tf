data "terraform_remote_state" "remote" {
  backend = "s3"
  config {
    bucket = "b49-rf-remote-state-bucket"
    key = "my-key-name"
    region = "my-region"
  }
}