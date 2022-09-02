# # Injecting the Schema
resource "null_resource" "mongod-schema" {
  
  depends_on  =  [aws_docdb_cluster.main]
  provisioner "local-exec" {
    command = <<EOF
    cd /tmp 
    curl -s -L -o /tmp/mysql.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
    unzip -o mongodb.zip 
    cd mongodb-main 
    mysql -h ${aws_db_instance.mysql.address}  -uadmin1 -pRoboShop1 <shipping.sql
EOF
  }
}