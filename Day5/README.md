# Terraform Provisioners

- Suppose our development team wants to modify application (app.py), they want devops team to create terraform project to test the changes. The dev team want us to create VPC, Public subnet with route tables and internet gateway
- Also we need to create EC2 and deploy our app,py into it and expose it to external world using URL. We can do that using opening port using Security group going to UI. But it willl take time if we create all the config manually.

- So after creating this project we need to implement CICD. Dev team will not share app.py file with us but they'll update it in GitHub and we can configure jenkins which will pull the changes using Webhook and will run the terraform.

----------------------------------------------------------------------------

Practical
-
- Write app.py as below

