# sample_ec2_webapp
Repository holds terraform code along with EC2 user data script to deploy a sample web application to AWS.

"Terraform Apply" command creates an EC2 instance in a VPC and applies the user data script upon initial EC2 server startup. Bash script configures and installs the application. Terraform at the end of the command "Terraform Apply" command provides address of your working web application. Application URL will be accessible once the EC2 instance is available and passes the health checks

Terraform Apply command expects a source_cidr range which is usually the external IP address of the machine accessing the web application. (e.g. "54.153.127.175/32"). This is used to restrict the traffic from  that IP address alone.

Terraform resources are generate as part of the following files:
app.tf - EC2 instance, Key Pair and Security Group
vpc.tf - VPC Module which covers VPC, Subnets, route table, internet gateway.

Resources generated with terraform:
1. VPC
2. Subnets - Private Subnets -2 & Public Subnets - 2
3. Internet gateway for Public Subnets.
4. Route Tables for Public and Private Subnets and corresponding route table association.
5. Key Pair
6. EC2 Instance
7. Security Group

Bash Script is provided as user data for the EC2 instance. Script does the following:

1. Installs Python3 and git to download the code from repo.
2. Create /apps directory and clone the target repository into the /apps directory.
3. Install module requirements via pip
4. Migrate the database and start the app in the background.

Prerequisites:
1. Terraform
