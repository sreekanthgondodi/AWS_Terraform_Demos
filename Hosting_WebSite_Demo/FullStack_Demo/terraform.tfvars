# Project wide variable
PROJECT_NAME                         = "demo"

# Variables for the providers
AWS_ACCESS_KEY                       = ""
AWS_SECRET_KEY                       = ""
AWS_REGION                           = "us-east-1"

# VPC variables
VPC_CIDR_BLOCK = "10.0.0.0/16"
VPC_PUBLIC_SUBNET1_CIDR_BLOCK         = "10.0.1.0/24"
VPC_PUBLIC_SUBNET2_CIDR_BLOCK         = "10.0.2.0/24"
VPC_PRIVATE_SUBNET1_CIDR_BLOCK        = "10.0.3.0/24"
VPC_PRIVATE_SUBNET2_CIDR_BLOCK        = "10.0.4.0/24"

# RDS variable
RDS_CIDR                              = "0.0.0.0/0"
DB_INSTANCE_CLASS                     = "db.t2.micro"
RDS_ENGINE                            = "mysql"
ENGINE_VERSION                        = "5.7.17"
BACKUP_RETENTION_PERIOD               = "7"
PUBLICLY_ACCESSIBLE                   = "true"
RDS_USERNAME                          = "test"
RDS_PASSWORD                          = "test123#$"
RDS_ALLOCATED_STORAGE                 = "10"

# EC2 Variables
SSH_CIDR_WEB_SERVER                   = "0.0.0.0/0"
SSH_CIDR_APP_SERVER                   = "0.0.0.0/0"
WEB_SERVER_INSTANCE_TYPE              = "t2.micro"
APP_SERVER_INSTANCE_TYPE              = "t2.micro"
USER_DATA_FOR_WEBSERVER               = "./Demo_Code/web.sh"
USER_DATA_FOR_APPSERVER               = "./Demo_Code/app.sh"
PEM_FILE_APPSERVERS                   = "newck"
PEM_FILE_WEBSERVERS                   = "newck"
