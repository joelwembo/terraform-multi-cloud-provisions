# terraform-provisions-examples
Terraform Provisions examples for AWS , GCP and Azure
![image](https://github.com/joelwembo/terraform-multi-cloud-provisions/assets/19718580/397d75d4-2d8c-4e87-850d-f812bce7ef89)

# Get Help
terraform -help — Get a list of available commands for execution with descriptions. Can be used with any other subcommand to get more information.

terraform fmt -help — Display help options for the fmt command.

# Show Your Terraform Version
terraform version — Show the current version of your Terraform and notifies you if there is a newer version available for download.

# Format Your Terraform Code
This should be the first command you run after creating your configuration files to ensure your code is formatted using the HCL standards. This makes it easier to follow and aids collaboration.

terraform fmt — Format your Terraform configuration files using the HCL language standard.

terraform fmt --recursive — Also format files in subdirectories

terraform fmt --diff — Display differences between original configuration files and formatting changes.

terraform fmt --check — Useful in automation CI/CD pipelines, the check flag can be used to ensure the configuration files are formatted correctly, if not the exit status will be non-zero. If files are formatted correctly, the exit status will be zero.

# Initialize Your Directory
terraform init — In order to prepare the working directory for use with Terraform, the terraform init command performs Backend Initialization, Child Module Installation, and Plugin Installation.

terraform init -get-plugins=false — Initialize the working directory, do not download plugins.

terraform init -lock=false — Initialize the working directory, don’t hold a state lock during backend migration.

terraform init -input=false — Initialize the working directory, and disable interactive prompts.

terraform init -migrate-state — Reconfigure a backend, and attempt to migrate any existing state.

terraform init -verify-plugins=false — Initialize the working directory, do not verify plugins for Hashicorp signature

See our detailed rundown of the terraform init command!

$ Download and Install Modules
Note this is usually not required as this is part of the terraform init command.

terraform get — Download and installs modules needed for the configuration.

terraform get -update — Check the versions of the already installed modules against the available modules and installs the newer versions if available.

Validate Your Terraform Code
terraform validate — Validate the configuration files in your directory and does not access any remote state or services. terraform init should be run before this command.

terraform validate -json — To see easier the number of errors and warnings that you have.

Learn how to validate your configuration locally.

Plan Your Infrastructure
terraform plan — Plan will generate an execution plan, showing you what actions will be taken without actually performing the planned actions.

terraform plan -out=<path> — Save the plan file to a given path. Can then be passed to the terraform apply command.

terraform plan -destroy — Create a plan to destroy all objects rather than the usual actions.

$ Deploy Your Infrastructure
terraform apply — Create or update infrastructure depending on the configuration files. By default, a plan will be generated first and will need to be approved before it is applied.

terraform apply -auto-approve — Apply changes without having to interactively type ‘yes’ to the plan. Useful in automation CI/CD pipelines.

terraform apply <planfilename> — Provide the file generated using the terraform plan -out command. If provided, Terraform will take the actions in the plan without any confirmation prompts.

terraform apply -lock=false — Do not hold a state lock during the Terraform apply operation. Use with caution if other engineers might run concurrent commands against the same workspace.

terraform apply -parallelism=<n> — Specify the number of operations run in parallel.

terraform apply -var="environment=dev" — Pass in a variable value.

terraform apply -var-file="varfile.tfvars" — Pass in variables contained in a file.

terraform apply -target=”module.appgw.0" — Apply changes only to the targeted resource.

# Destroy Your Infrastructure
terraform destroy — Destroy the infrastructure managed by Terraform.

terraform destroy -target=”module.appgw.0" — Destroy only the targeted resource.

terraform destroy --auto-approve — Destroy the infrastructure without having to interactively type ‘yes’ to the plan. Useful in automation CI/CD pipelines.

terraform destroy -target="module.appgw.resource[\"key\"]" — Destroy an instance of a resource created with for_each.

‘Taint’ or ‘Untaint’ Your Resources
Use the taint command to mark a resource as not fully functional. It will be deleted and re-created.

terraform taint vm1.name — Taint a specified resource instance.

terraform untaint vm1.name — Untaint the already tainted resource instance.

Refresh the State File
terraform refresh — Modify the state file with updated metadata containing information on the resources being managed in Terraform. Will not modify your infrastructure.

View Your State File
terraform show — Show the state file in a human-readable format.

terraform show <path to statefile> — If you want to read a specific state file, you can provide the path to it. If no path is provided, the current state file is shown.

# Manipulate Your State File
terraform state — One of the following subcommands must be used with this command in order to manipulate the state file.

terraform state list — Lists out all the resources that are tracked in the current state file.

terraform state mv — Move an item in the state, for example, this is useful when you need to tell Terraform that an item has been renamed, e.g. terraform state mv vm1.oldname vm1.newname

terraform state pull > state.tfstate — Get the current state and outputs it to a local file.

terraform state push — Update remote state from the local state file.

terraform state replace-provider hashicorp/azurerm customproviderregistry/azurerm — Replace a provider, useful when switching to using a custom provider registry.

terraform state rm — Remove the specified instance from the state file. Useful when a resource has been manually deleted outside of Terraform.

terraform state show <resourcename> — Show the specified resource in the state file.

Import Existing Infrastructure into Your Terraform State
terraform import vm1.name -i id123 — Import a VM with id123 into the configuration defined in the configuration files under vm1.name.

# VPC
![image](https://github.com/joelwembo/terraform-multi-cloud-provisions/assets/19718580/7743ffd6-d669-40ae-b7ab-2b63304fd350)


  Amazon Virtual Private Cloud (Amazon VPC) gives you full control over your virtual networking environment, including resource placement, connectivity, and security. Get started by setting up your VPC in the AWS service console. Next, add resources to it such as Amazon Elastic Compute Cloud (EC2) and Amazon Relational Database Service (RDS) instances. Finally, define how your VPCs communicate with each other across accounts, Availability Zones, or AWS Regions. In the example below, network traffic is being shared between two VPCs within each Region.

  
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.

