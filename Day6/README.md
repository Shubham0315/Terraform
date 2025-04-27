# Terraform Workspaces

- Suppose our dev team want to setup EC2 and S3. They create JIRA request for devops team.
  - As these EC2 and S3 are commonly used resources. Any other team might also request the same to us.
  - So instead of writing terraform project we write terraform module so it can be reused in future. Also with creation of module we can create README on how to use it.
  - So in modules, instead of writing terraform projects we write module which is reusable
 
- Still dev team will have issue.
  - They can say the module is very good and has been tested in dev env where with main.tf entire config is written. To variabalize, terraform.tfvars is also written where we can define EC2 config without hardcoding.
  - But they also have staging, prod env. To create resources on diff env with diff configs(EC2 being t2.medium or t2.large). For this one solution can be writing main.tf and vars file for each env.
 
- Here as a devops team, we can write main.tf. We can ask dev team to create dif vars files for diff env as dev.tfvars, prod.tfvars.
  - This cannot solve our problem as there is terraform statefile which records info.
  - If we execute main.tf and dev.tfvars to create EC2 on dev env, statefile will record it. If we try to do same for prod, statefile will get overridden or statefile will get confuse if we're trying to modify vars in dev env only. It doesnt know we're having multiple envs to deal with. It will try to delete EC2 for dev and try to create new for prod env which is not expected behaviour as we want diff infra for each env without need to write different folders and files for each env.
 
- Here terraform workspaces comes into picture. They solve the problem of single state file. It will create statefile for diff envs which will be unique. So we dont need to write terraform project again and again.
- When we create infra for dev, dev.statefile is updated and EC2,S3 gets created in dev env. When we execute it for prod, that mentioned infra will be created.

-------------------------------------------------------------------------------------

Practical
-
- Create folder named "modules/ec2" and write main.tf like below. Define 2 variables for ami and instance type to use in resources section (Not hardcoded anything)

![image](https://github.com/user-attachments/assets/7056066a-61e4-4971-a03b-a71d5767a24e)

- So any team if want to use, can use it.

- Now create another main.tf in root directory of our folder.(Earlier we created in /modules/ec2)

![image](https://github.com/user-attachments/assets/a2df9820-fc16-44f0-9aef-5e45d707416c)

- This main.tf will be for project team. Here provide info. Now we've to use terraform.tfvars and submit values to EC2. For that again setup variables ami and instance_type.
  - Define modules with source from where we need to get configs, define ami and instance tye in it. 

![image](https://github.com/user-attachments/assets/d8e03de9-f367-4196-87e4-0a2a8ab4b4e0)

- When we're writing modular approach code, only thing we need to write is variables and how to consume modules

- The above module will get invoked if we have tettaform.tfvars.
  - Create tfvars file. Define ami and instance type values
 
![image](https://github.com/user-attachments/assets/d7c2b58a-3cba-4e74-a462-ab2ff4652384)

- Here we've only 1 env. We can go to folder and initialize the project and then apply. It creates EC2 for us which will be acc to variables we've provided. Also statefile gets created for us at root level of our dir. Once EC2 is created, statefile gets updated

![image](https://github.com/user-attachments/assets/17e10602-d430-4894-93ef-3f466667dafa)
![image](https://github.com/user-attachments/assets/cf02680e-e093-44bb-aadc-4b76eb455837)

- Now for diff enev, create state.tfvars and define instance type as "t2.medium"

![image](https://github.com/user-attachments/assets/3d10e4fd-afa8-4711-ae3c-fdb1af6092c7)

- Now currently in our state file, what is present can be seen by "terraform show" command. We can see 1 resources as EC2 with instance ID and required config.

- Now if we execute stage.tfvars code , it should keep previous env and create new EC2 with t2.medium
  - Command :- **terraform apply -var-file=stage.tfvars**
  - While executing apply, we can seethere is no addition, it is changing the existing instance which is nt expected, so we can terminate it.
 
![image](https://github.com/user-attachments/assets/9bf3d0ad-d9d4-414c-b687-dfa795a53197)
 
- So we can say we cannot create tfvars for diff env in root dir as it doesnt create diff infra. So we can use terraform workspaces for the same
  - Delete unnecessary files so we just have below files
 
![image](https://github.com/user-attachments/assets/f81d53f8-cc0d-41c2-acbc-8974da6240ea)

- Run below command to create new workspace
  - Command :- **terraform workspace new dev**
  - So a new folder gets created named "terraform.tfstate.d" inside which dev dir is there
  - Similarly do create ws for stage and prod, we can see diff env as below
 
![image](https://github.com/user-attachments/assets/ab442b82-3737-4f2a-9d0b-cc9045129053)
![image](https://github.com/user-attachments/assets/72590636-d699-4937-881f-aa446a3046bc)

- Now switch to dev workspace
  - Command :- **terraform workspace select dev**
  - To see in which WS are we :- **terraform workspace show**

![image](https://github.com/user-attachments/assets/8602d89c-9a80-42e4-a0d1-868a606e1a9a)

  - Here we can execute tfvars file. Init and apply
  - We can see statefile gets created inside specific folders/env but not at root

![image](https://github.com/user-attachments/assets/0ecce62f-4ed5-4982-b2c2-025d346d2b7c)

  - This state file will be for dev and will not impact stage or prod env
  - As long as we're in dev workspace and make any changes, it will be applicable for dev env only

![image](https://github.com/user-attachments/assets/30dcc3f7-4bef-433c-8d2c-bb1f2ae13713)

- Now switch the workspace and also change instance_type in tfvars to "t2.medium"
  - Now here after applying, it will not change the resource, it will add the resource
  - New file tfvars gets created inside stage folder
 
![image](https://github.com/user-attachments/assets/52b0be20-769b-4504-bb9a-2daa31f4527a)
![image](https://github.com/user-attachments/assets/eb212650-a4f8-4b0e-b3b5-273fffe7eea4)
![image](https://github.com/user-attachments/assets/08f3d62e-31e7-437e-8736-ab9e8625495b)


- EC2 is simple resource. But replicating entire config for diff env can be a huge task if workspaces are not used.

- Instead of modifying tfvars file again and again, what we can do as a devops engineer as its not a good practice.
  1. We can create tfvars file for each env like dev.tfvars, prod.tfvars. Instead of updating when we run apply pass it in command
  - Command :- **terraform apply -var-file=prod.tfvars**

  2. Remove variables from tfvars and add it to variables section in main.tf defining type as map(string)
  - Also use lookup function in module for instance type. Here we need to provide which value to lookup (instabce), key string (dev/prod/stage), default value (if nothing is there)
  - Syntax :-   **instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")**

  - When we execute this code, the "terraform_workspace" variable inside lookup block will get changed to stage and lookup fucntion will go to instance type and search for stage and if stage is available, it will take t2.medium to create required instance
 
![image](https://github.com/user-attachments/assets/92c5b9e3-367e-4fda-8df7-c9f89c131262)

  - Go to prod workspace (select it) and apply. It should create "t2.xlarge" instance
  - terraform.workspace variable in lookup will be resolved to prod and fetch value for prod t2.xlarge
  - Now see in AWS console if our instance got created

![image](https://github.com/user-attachments/assets/c0012c07-12a6-49fb-bd64-5ee574c715a5)

