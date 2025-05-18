# Terraform Provisioners

- Suppose our development team wants to modify application (app.py), they want devops team to create terraform project to test the changes. The dev team want us to create VPC, Public subnet with route tables and internet gateway
- Also we need to create EC2 and deploy our app,py into it and expose it to external world using URL. We can do that using opening port using Security group going to UI. But it willl take time if we create all the config manually.

- So after creating this project we need to implement CICD. Dev team will not share app.py file with us but they'll update it in GitHub and we can configure jenkins which will pull the changes using Webhook and will run the terraform.

----------------------------------------------------------------------------

Practical
-
- Write app.py as below

![image](https://github.com/user-attachments/assets/863c247f-17da-415d-8806-f35e5f5e3403)

- Write the main.tf for all reasources of VPC, EC2, etc
  - Specify region.
  - CIDR block to be defined
  - Define key pair
  - Define VPC block. Variablize the VPC block using CIDR above
 
  - VPC - SUBNET

![image](https://github.com/user-attachments/assets/97829a06-4cce-462f-8277-0bbbc8df06e2)

  -  Then write logic for subnet. Subnet has to be inside the defined VPC only. CIDR block inside this is for subnet. Define AZ.
  - We also need to create Internet gateway, route table and attach the internet gateway as destination.

![image](https://github.com/user-attachments/assets/e0059d8a-5f4c-4cdb-aa12-12ce371da84e)

  - Now associate the route table with subnet
  - To expose EC2 on public IP using SG

![image](https://github.com/user-attachments/assets/e52aa2af-40e9-4fde-bbb5-6d5714e59d74)

  - In terraform inbound config are defined using ingress and outbound configs are defined using egress. In ingress we opened port 80 (HTTP) and 22 (SSH). In egress, we can define if resource wants to access anything from outside world.

![image](https://github.com/user-attachments/assets/3d9f5aa5-5d01-4b6f-b724-ab386acd0cbe)

  - Now for EC2 config, Define AMI, instance type, key pair created above, SG, subnet ID
  - Define connection settings to be done to EC2. Here use SSH, user as ubuntu, use private key to connect to EC2. Host details means public IP

![image](https://github.com/user-attachments/assets/93ae3bca-49f6-4a0f-8f46-b303a59062fc)

  - To deploy app on EC2, we need provisioners.
  - To use provisioners we need to first connect to instance which we did above.
  - Here we are using file provisioner using which we're copying app.py onto EC2. So source is app.py and destination is provided as required.
  - Use another provisioner "remote-exec" to execute all commands on EC2

![image](https://github.com/user-attachments/assets/c0e9ea37-7523-4b3f-8de6-410dc9e4f09c)

  - Now run terraform init and then plan which will create VPC, key value pair, subnet, route table, IGW, associate IGW with subnet, EC2, associate SG with EC2.
  - Then apply the config

![image](https://github.com/user-attachments/assets/fcce4ee0-9bca-4b0a-a8ad-0167871adbe4)

  - We saw how to run scripts and create resources on terraform. For that provisioners will eliminate manual intervention and app gets available to users. Here we've automated entire process which is zero touch automation. Users will go to the public IP and access the application.
  - Terraform here connects to EC2 and copied the file and installs whatever needed.
  - We can check on AWS console if EC2 is created.
  - To login to EC2, get public IP and run :- **ssh -i ~/.ssh/id_rsa ubuntu@IP**
  - We can check if app.py is copied using ls command (Defined in app provisioner)
  - To check python running process :- **sudo ps -ef | grep python**


![image](https://github.com/user-attachments/assets/0a21b342-04ce-49e1-99e4-8a3ad85057d2)

  - Developer has shared app.py with us and entire project is executed by us. Dev team will verify the implementation

----------------------------------------------------------------------------

Provisioners Theory
-
- We used provisioners to execute and implement actions during creation.
- While creating EC2 we copied file on EC2 and executed commands on it.
- So provisioners lets us to copy things or execute actions at time of creation or destroy.

- As devops engineers, we see challenges with terraform. Here we created EC2 but we were not able to install python if we dont use provisioners.
- If terraform doesnt have provisioner, we need to use ansible, shell script to connect to EC2 and run python app.

- To solve this terraform provides us 2 things :- Remote exec provisioners and local exec provisioner
  - **Remote exec** :- at time of EC2 creation, we can connect to it and we'll execute any commands like install python, node js.
  - **Local exec** :- To print anything on console, when we run apply it print everythin on console. If our project has 1000s of lines to print on console and we need just specific lines, we use local exec and ask terraform to copy all outut to a file (overwrite or append).
 
- File Provisioner
  - Used to copy files. In EC2 we need to copy 10 files, we can use file provisioner (defined in main.tf of above project)
