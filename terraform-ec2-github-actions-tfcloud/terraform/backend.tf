# terraform {
#   backend "s3" {
#     bucket         = "cloudapp-app-12"
#     region         = "ap-southeast-1"
#     key            = "state/terraform.tfstate"
#     dynamodb_table = "data_onents_tf_lockid"
#     encrypt        = true
#   }
# }

terraform {
  backend "remote" {
    
    hostname="app.terraform.io"
	  token = "token here"
   
    organization = "cloudapp" 
    workspaces {
      prefix = "cloudapp-" 
    }
  }

  
}

