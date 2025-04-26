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
- 
