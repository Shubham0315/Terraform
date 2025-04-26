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
  - So if code change is made, the change should be executed and update statefile in local and push it to VCS as well.

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
- If our team has GitHub repo hosting terraform code. So instead of strong state file in GitHub we use S3 as remote backend. Even if any our team member wants to update logic, they can clone repo on laptop, make chnages and after verifying, they'll raise Pull Request PR back to GitHu repo. As they have applied config, it will also update S3 with logic. State file gets updated in S3

----------------------------------------------------------------------------------------




