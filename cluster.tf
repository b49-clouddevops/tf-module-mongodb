# Created Document DB : A Managed service for MongoDB
resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-${var.ENV}"
  engine                  = "docdb"
  master_username         = "admin1"
  master_password         = "roboshop1"
  skip_final_snapshot     = true   # terraform destroy won't ask you that do you need a backup before deletion or not
  db_subnet_group_name    =  ??????
}


# Creating Subnet Grouo 
resource "aws_docdb_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.frontend.id, aws_subnet.backend.id]

  tags = {
    Name = "My docdb subnet group"
  }
}