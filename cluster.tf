# Created Document DB : A Managed service for MongoDB
resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-${var.ENV}"
  engine                  = "docdb"
  master_username         = "admin1"
  master_password         = "roboshop1"
  backup_retention_period = 5
  skip_final_snapshot     = true
}