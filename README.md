# Terrafom_project

# Terraform EC2 Load Balancer Setup

This Terraform project creates two EC2 instances behind an AWS Application Load Balancer (ALB). It uses user data scripts to differentiate between the two instances, allowing you to see the difference when accessing the load balancer.

## Prerequisites

Before you begin, make sure you have the following:

- Terraform installed on your machine.
- AWS account with necessary permissions to create resources like EC2, ALB, Security Groups, etc.
- AWS CLI configured with the proper credentials.

## Project Structure
main.tf # Main Terraform configuration to provision resources
provider.tf # Defines the AWS provider and region 
outputs.tf # Outputs relevant information (ALB DNS name) 
user_data1.sh # User data script for EC2 instance 1
user_data2.sh # User data script for EC2 instance 2

## Setup and Configuration

1. **Clone this repository to your local machine**:

   git clone https://github.com/Saikumar099/Terrafom_project.git
   cd Terrafom_project

2. Modify AWS region (optional):

If you want to deploy the resources in a specific AWS region, edit the provider.tf file and update the region parameter.

3. Initialize Terraform:

Run the following command to initialize the Terraform configuration and download necessary providers.

     terraform init

4. Plan the Deployment:

Run the following command to preview the resources that will be created:

     terraform plan

5. Apply the Configuration:

To create the resources, run:
 
     terraform apply

6. Access the Load Balancer:

Once the resources are created successfully, Terraform will output the DNS name of the Application Load Balancer (ALB). You can access this URL in your browser to see the difference between the two EC2 instances.

7. Cleanup:

To remove all resources created by Terraform, run the following command:

     terraform destroy

Explanation of Files:
----------------------
provider.tf: Configures the AWS provider to allow Terraform to communicate with your AWS account.
main.tf: Contains the core infrastructure setup, including the creation of an ALB, two EC2 instances, and a security group to allow traffic to the instances.
outputs.tf: Defines the output for the ALB's DNS name, which you can use to access the load balancer.
user_data1.sh: Script for the first EC2 instance. This script can output a unique string or message to indicate it's instance 1.
user_data2.sh: Script for the second EC2 instance. This script can output a different message or string to indicate it's instance 2.
