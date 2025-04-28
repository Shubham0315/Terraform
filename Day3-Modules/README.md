# Terraform Modules

- Our organization has million lines of source code written in java with monolith architecture.
- If there is a bug in app, we might face below challenges in monolith architecture:-
  - For a new person to locate is is difficult.
  - Also there will be lack of ownership as we dont know who developed the code/function logic.
  - Maintenance will also be very difficult in this case as during updates we need to ensure there are no security vulnerabilities.
  - We also need to deploy entire app so testing will also be difficult as we dont know which part to test
 
- Thats why industry has moved to Microservices architecture. Here in terraform its related in below mentioned way

- In terraform, there will be one provider we need to update. For the development team we might need to create lot of resources like VPC, EC2, LB, Lambda, S3. If we try to put all these things in one single terraform project, project might end up like monolith project as we have everything in one terraform project
  - Here if we found bug in project, new person cant locate it
  - Also we dont know who owns the file/change
  - To maintain terraform project is also a headache here
  - Testing will also be difficult due to single project package
 
- If we have written logic for VPC, S3, EC2, LB in main.tf file and we need to fix a bug related to EC2. So devops team will create PR in Git repo addressing changes for EC2.
- So its important not to create everything in one single take. As devops, we will follow Modular approach here which is called as "Modules" in terraform

- Modules have below advantages:-
  - Modularity :- Modules allow to break down our infra configuration into smaller components
  - Reusability :- Write EC2 as module and we can do maintenance easily with taking ownership of resources. We can use module written and provide to other teams as well or other projects
  - Versioning and maintenance :- Modules have versioning to manage updates and changes
  - Abstraction :- Modules can abstract complexity of underlying resources
  - Documentation :- 
  - Scalability :- As your infrastructure grows, modules provide a scalable approach to managing complexity
  - Security :- Modules can encapsulate security and compliance best practices.

--------------------------------------------------------------------------------------

Practical Implementation
-
- Create main.tf file. Write EC2 instance creation logic. Use variables part as well

![image](https://github.com/user-attachments/assets/4d640e80-2850-4d2d-bc95-79aefd0780d0)

- Now we need to provide values for variables. We can hardcode them but in organizations we can use tfvars file and assign values inside it to use by variables.
  - If we've defined default values in variables, we dont need to refer tfvars file.
  - If we dont want to reveal sensitive info to world which is in main.tf, we can put that thing in tfvars file
 
- Take ami value from AWS console for ubuntu instance, put in tfvars file. Set "instance_type_value" in main.tf as "t2.micro" inside tfvars. Add subnet id value (not required for us).

![image](https://github.com/user-attachments/assets/0d7a0525-9b3c-4c61-b7da-d19db7e78e54)
![image](https://github.com/user-attachments/assets/e8e9ffbd-16dc-48cc-8658-3bf58f267a64)

- Now when we do "terraform apply", terraform will auto check tfvars file, understand which fields to replace to variables.
  - If any other project developer needs tfvars file for their project, they can take referance from it and do changes which are required
  - For info like access keys, IAM policy info we dont need to checkin to github repo, we can put them in tfvars
- Also we can create different file for variables variables.tf and put variables info there
- We can also create new file for provider "provider.tf" (if required).
- So now our files look like below

![image](https://github.com/user-attachments/assets/a8682534-7757-49b5-b791-f1821326cfd1)
![image](https://github.com/user-attachments/assets/2931dbc5-72cc-4efe-843e-a56c3f4328b7)
![image](https://github.com/user-attachments/assets/08bacfd4-9784-4f86-8abd-2aac40e31c08)

- Now initialize the repo first. It will initialize backend, understand the provider
- Then do terraform plan. Here in output we can see values assigned to ami and instance type (variables values)
  - This means while initializing understands that we're using tfvars and replaced variables with values assigned
  - Check for the region while taking ami id and applying the same

![image](https://github.com/user-attachments/assets/0fa0bbe3-badd-412f-a65d-39c518509c54)

- Now do terraform aply. 

![image](https://github.com/user-attachments/assets/ab3bf5d3-d46c-4cfa-a265-4d9fe155d396)
![image](https://github.com/user-attachments/assets/74e80c0e-3cf6-41ff-bd44-cc162f70f32a)

- The resource is created now. But how would others know what is created, what is IP of EC2. For this, we can use concept of "outputs" in terraform

- First destroy this project and add output field. Create "outputs.tf" file and provide IP config there in the format "resourceName.attribute"

![image](https://github.com/user-attachments/assets/26c7574d-571f-48d7-9179-795d88b16476)

- Now after applying, we get IP of instance. We'll also get what changes we're making in output

![image](https://github.com/user-attachments/assets/97e29620-2bab-4293-87b1-4f88b5fff6c9)


--------------------------------------------------------------------------------------

Modularize Terraform Project
-
- Create new folder named "modules/ec2_instance" in day3 folder and move all the files inside it (just drag and move)

![image](https://github.com/user-attachments/assets/160fce8c-a6a9-46b4-b9c1-8ab747820501)

- Now delete tfvars file. In modules we dont need tfvars to be written. People executing modules need tfvars
  - Now any member in our organization will simply create new file main.tf and write provider, region.
  - Then provide module section where define from where we need to source the info
  - Define ami and instance_type value
  - Note this main.tf is not of our project, other team has created it
 
![image](https://github.com/user-attachments/assets/72c118ba-b16e-4150-add6-fbe77d380c32)

- Here instead of writing whole terraform code, someone has created module in their own folder (just need to know location)
- So next time whe  someone write main.tf, they can write just this code in main.tf instead of writing entire files in the folder previously (main.tf, variables.tf, output.tf)
- After applying, we can see as we're consuming the module, instance will get created

![image](https://github.com/user-attachments/assets/0bb701b3-45fb-43f4-b2e4-8804049c1db9)

- So other members need to write this simple block of code of "modules". So we're developing reusable code here with easy maintenance. We just need to maintan the module block

- We can use modules to make our code or resource creation reusable for other members in organization

--------------------------------------------------------------------------------------

To use public modules, similar to dockerhub we've terraform registry where we get bunch of modules from where we can get reference for syntax.
- Instead organizations write their own modules and put in their private github repository from where we can reference the modules 
