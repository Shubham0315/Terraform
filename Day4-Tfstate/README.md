# Terraform State

- Statefile is a heart of terraform using which terraform will record or store info about infrastructure it has created
- In our terraform project we've written logic for EC2 creation. After applying EC2 will get created. Along with creating resource, terraform will also store info in state file.

- What is terraform doesnt store the info :-
  - If we need to modify EC2 after some days, like adding tag to EC2 along with type and ami.
  - So we'll also provide tag to resource block. If there is no state file, terraform will not understand that it has already created instance with same name. So EC2 with same name is created which is not expected.
  - State file, when we execute apply terraform will go to state file before applying and check what infrastructure is already created and what new it has to create.
  - So using state file it will compare the difference (tag). Here in our case terraform just need to update tag of EC2
 
  - If there is no state file, terraform will not know it has to update infrastructure rather than creating new one.
 
  - When we run terraform destroy, it will again check state file what is created and tell user what it is destroying before prompting for input "yes"
 
- In short state file records infrastructure already created, help to update existing, destroy existing infrastructure as well.

- **Drawbacks**
  - Any action performed using terraform is recorded in state file. But if we dont want to store some sensitive info (passsword) in state file, by default terraform doesnt promote it. So who has access to infrastructure where we're storing project can access the sensitive info as well.
  - We can store all terraform logic in VCS and if VCS is compromised, people having access to VCS can see state file. Even if we restrict access to our GitHub, and if any of our devops team who has access to it modifies the config and applies it, resources will get created and he will push changes to github as well. Statefile also gets generated after applying. If devops engineer just updates the file but doesnt apply config, as statefile is not created, terraform will not know if any logic is updated.
  - So if any code change is made, the change should be executed and update statefile in local and push it to VCS as well.

----------------------------------------------------------------------------------------

Remote Backend
-
- To fix drawbacks, there is concept of "remote backend" in terraform.
- If we've challenge to store terraform state file in GitHub repository, we can store it in external resources like S3 bucket and we dont need to bother about state file in our local. If we configure remote backend, instead of statefile getting created on laptop or VM, it gets created on S3 bucket. S3 hosts our state file
- If state file is hosted by S3, we can completely restrict S3 access. Also, as configs are applied statefile will get auto updated in S3 bucket as well.
- After running terraform init, terraform understand to get info from state file in S3.

- Previously it used to compare state file in local and logic in Git repo. Now it will compare with S3 and code in git repo. S3 makes it secure.

Workflow of Remote backend
-
- If our team has GitHub repo hosting terraform code. So instead of storing state file in GitHub we use S3 as remote backend. Even if any our team member wants to update logic, they can clone repo on laptop, make chnages and after verifying, they'll raise Pull Request PR back to GitHu repo. As they have applied config, it will also update S3 with logic. State file gets updated in S3

----------------------------------------------------------------------------------------

Practical
-
- Create main.tf. 

![image](https://github.com/user-attachments/assets/4079109e-8734-4bfe-af2b-fa39857d8d45)

- To check if state file is present :- **terraform show**

![image](https://github.com/user-attachments/assets/11f95f53-e78c-4637-a5c9-263ea8093dc8)

- When we do terraform init, couple of files get generated in the folder :- .terraform.lock.hcl

- Now apply the config. State file now gets created in the folder. Once config is created, state file will get polulated with fields

![image](https://github.com/user-attachments/assets/b595703f-d230-44f6-962a-dc750a17f0c6)

- Here we can see instance config as well lie id, ami, ip etc.

- If statefile has all the fields/variables, outputs are needed as developers if want to make changes to project, they dont have access to state file as it is sensitive.
- Using state file terraform records all info.

![image](https://github.com/user-attachments/assets/395d14b9-fb9e-4e6b-b617-414d81b41ca6)

- Delete the state file. Now if we do terraform plan, it will again create state file and create EC2 once applied. Instead it should show us EC2 is already there

- Now lets use S3 bucket as remote backend. Create backend.tf file where we need to provide backend config.
  - Go to terraform docs and get the syntax which is one time config.
  - For S3, provide bucket, region, key
 
- But first write bucket logic in main.tf and create bucket

![image](https://github.com/user-attachments/assets/9fee4ce3-b02e-4ebd-bbf9-3c37ea5ea79e)

- Now init and apply

![image](https://github.com/user-attachments/assets/970d1503-67bb-4fbb-84ba-b3358822f182)
![image](https://github.com/user-attachments/assets/8c9f8a8f-90c9-472e-9165-ac759e7aca0c)

- Now in the backend.tf file, provide bucket name with region name

![image](https://github.com/user-attachments/assets/8d6a9e5d-5b73-4985-abe8-1701a5c0fa27)

- Now delete the state file and re-initialize the project. Now state file will be changed to S3. So we've successfully configured backend called S3

![image](https://github.com/user-attachments/assets/e1a323a6-56d8-4e6a-a9dd-d39c59f9628a)

- Now when we apply, state file will be created in S3, not local

![image](https://github.com/user-attachments/assets/001160d7-dddf-4669-b64b-7fff1a12348a)
![image](https://github.com/user-attachments/assets/a6791e4b-1b10-497a-b4d5-b37a75a7f74f)

- This is how we can modify our terraform logic not to store state file on local but store in S3 bucket
  - Now if we do terraform show, it will read info from S3 bucket.
  - This is how we make use of remote backend
  - So if devops engineer has to make code changes to main.tf, we just need to update resource in main.tf and dont need to bother about state file. Also state file access will be restricted to only those who have access to S3.

----------------------------------------------------------------------------------------

Locking Mechanism
-
- When we run commands, terraform will try to take lock or cotrol the statement. Terraform creates lock file in local and terraform tries to control lock file
- If 2 people are trying to update same project, and they try to apply at same time.
- Everytime terraform takes control of state file, lock state file, one person at a time can hold the lock. Other has to wait until execution is done of first
- So locking is imp as if multiple people tries to update same project only one person will do at a time.
- For this we need to maintain lock somewhere like dynamoDB on AWS using which we can implement locking mechanism.

- Use "dynamodb_table" inside which we define person who holds the lock. So table name is "terraform_lock"

![image](https://github.com/user-attachments/assets/cff3c5ae-bf54-430e-af82-3a2c7ad591f7)

- Now using it, we can say person1 holds lock as he is executing it. Once he's done, lock will be removed and other person will hold the lock.

- Before running apply command, terraform will check if anyone holds the lock and if it is it will hold the execution.
- Now in backend file provide lock details with table name
- First execute main.tf apply so S3 and dynamodb will get created. After that execute backend as well so locking gets implemented

![image](https://github.com/user-attachments/assets/0e71b2f4-eb6a-4ee7-857c-7a3e82d3299a)
