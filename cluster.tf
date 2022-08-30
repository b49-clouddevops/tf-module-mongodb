# Created Document DB : A Managed service for MongoDB
# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier      = "roboshop-${var.ENV}"
#   engine                  = "docdb"
#   master_username         = "admin1"
#   master_password         = "roboshop1"
#   skip_final_snapshot     = true   # terraform destroy won't ask you that do you need a backup before deletion or not
#   db_subnet_group_name    =  ??????
# }


# Creating Subnet Grouo 
resource "aws_docdb_subnet_group" "docdb" {
  name       = "roboshop-${var.ENV}"
  subnet_ids = data.terraform_remote_state.vpc.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop"
  }
}