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
- 
