# Created Document DB : A Managed service for MongoDB
resource "aws_docdb_cluster" "main" {
  cluster_identifier              = "roboshop-${var.ENV}"
  engine                          = "docdb"
  master_username                 = "admin1"
  master_password                 = "roboshop1"
  skip_final_snapshot             = true
  db_subnet_group_name            = aws_docdb_subnet_group.docdb.name
  vpc_security_group_ids          = [aws_security_group.allow_mongodb.id]
}


# Creating Subnet Group
resource "aws_docdb_subnet_group" "docdb" {
  name       = "roboshop-${var.ENV}"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-${var.ENV}"
  }

}

resource "aws_docdb_cluster_instance" "cluster_instancess" {
  count              = 1
  identifier         = "roboshopp-${var.ENV}-${count.index}"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = "db.t3.medium"
  depends_on = [
     aws_docdb_cluster.main
  ]
}

resource "aws_security_group" "allow_mongodb" {
  name        = "roboshop-mongodb-${var.ENV}"
  description = "roboshop-monogdb-${var.ENV}"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID
  depends_on = [
     aws_docdb_cluster.main
  ]

  ingress {
    description = "TLS from VPC"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, var.WORKSPATION_IP]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "roboshop-mongodb-${var.ENV}"
  }
}