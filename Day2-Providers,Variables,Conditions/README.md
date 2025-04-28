# Providers, Variables and Conditions

Providers
-
- When we create EC2 or any resources using terraform, first thing we write in tf file is provider block with region mentioned.
- If we dont mention provider in tf file, how will terraform know where to create the resource or which cloud provider to authenticate?

- So provider acts as a plugin which helps terraform to understand where it has to create infrastructure.

- To create resources on other cloud, go to terraform providers page.
  - Official providers are GCP, AWS, Azure which are maintained by terraform
  - Partner providers like alibaba, oracle themselves provide logic to terraform to manage resources
  - Community providers are created by normal users and open source will maintain them
 
- To setup infrastructure in multiple regions or multiple cloud (in case our organization works on hybrid cloud)

**1. Multi Region**
- Write 2 provider blocks for us-east-1 and us-east-2.
- Use "alias" keyword
- In the resources block, provide "aws-instance" and "ami" to be used with instance type
- Then in both resources block, write provider as "provider = "aws.$aliasName"
- So that using alias defined in provider block, terraform will understand to create AWS resource in particular region
- Even we can define alias as "abc", "xyz", not necessarily regionName

![image](https://github.com/user-attachments/assets/2a18169c-bc08-4786-8ae6-41bd8f9d4489)

**2. Multi Cloud**
- In this case write providers info in provider.tf file like AWS or azurerm.

![image](https://github.com/user-attachments/assets/2af3db8c-236e-4c75-bdbb-df2eea5b0426)

- Then write main.tf file to define resources

![image](https://github.com/user-attachments/assets/01925d21-20dd-4954-9a63-18343b70e311)

- We can take syntax from terraform documentation for different providers
- Here we dont need to remember the syntax, just need to know the skeleton

------------------------------------------------------------------------------

Variables
-
- Variables are used to parameterise the things. To pass values to project. They allow you to make your configurations more dynamic, reusable, and flexible.
- In our last main.tf where we created EC2, we've hardcoded AMI or instance_type which is not good practice. If any team comes up with same request to create EC2, we need to write the main.tf again as values were hardcoded.
- So we can replace those things with variables.
- 2 types of terraform variables :- Input and Output
- If we've to pass values to terraform modules or configs, we can use input variable and if we want terraform to print specific value in output (to print publicIP in output of EC2). Output variables allow to expose values from modules or configs, making them available to use in other parts of terraform setup.

- Create main.tf and write provider, resource details. In between provider and resource blocks, write all variables to use

![image](https://github.com/user-attachments/assets/73210d11-1d54-4eb5-951b-9e65c6f59e17)

- When we use "var.instance_type" it gets replaced by default value provided in variables block (t2.micro)
- Thus we use it in variables section without hardcoding it
- We can also pass values to the variables using terraform apply command
- We can also define variables in different file as well known as tf.vars

- So using variables we try to parameterise our terraform project without hardcoding values. We can reuse the project for different teams requirements

- For the output variables, syntax starts with "output" keyword and we want to print something after our apply command is successful
  - So in above SS we've used to print public IP f the insatnce once its created. Define value attribute inside output block as "**resource.resource_name.variable**"

![image](https://github.com/user-attachments/assets/61537d11-59df-404f-92ea-2ad6ef6fef4b)

- To make project cleaner we can do below:-
  - Provider config can be written in provider.tf file.
  - Input variables to pass can be written in inout.tf
  - Output variables in output.tf
  - Main.tf to be used for actual configuration of resources
  - terraform.tfvars
 
**Terraform.tfvars**
- To parameterise values of default variables completely, means when we execute project we want to take values of variabls dynamically (read -p like thing)
- They allow you to separate configuration values from your Terraform code, making it easier to manage different configurations for different environments (e.g., development, staging, production) or to store sensitive information without exposing it in your code.
- Tfvars is used for it.
- We create terraform.tfvars inside which we write actual values of variables. So if any team wants to execute project acc to their requirements, they'll change this tfvars file only (imagine diff types of instances for dev, prod)
- So we create variable inside input.tf but pass its value in tfvars file
- If we are using tfvars file with other names like (dev.tfvars) we can pass it while running apply command (just like docker compose or kubectl)

------------------------------------------------------------------------------

Conditional Expressions
-
- If we need to execute values inside resource block for differnet environments like dev, prod we can use conditions
- To create S3 on dev and enable public bucket access to host static website and for prod cluster we dont want to enable public access, here we can use conditional actions (if conditions)
- Syntax :- condition ? true_val : false_val
  - If condition is true execute first value, if false execute 2nd value (true_val and false_val are provided in conditional)
 
- To crete SG and allow traffic, provide condition as if env is prod then allow SSH access to prod CIDR block else allow SSH to dev CIDR block. We've used variables here.
  - We've defined CIDR/subnet ranges for the env blocks to allow SSH traffic
 
![image](https://github.com/user-attachments/assets/0fe0feb6-7b56-4ff4-b9ac-18b945b81c53)

- They help to execute our resources using conditions
