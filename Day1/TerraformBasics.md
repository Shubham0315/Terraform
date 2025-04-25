Getting started with Terraforn
-
- To create S3 on AWS - Go to AWS Console - Provide user and pass to authenticate - Search for S3 - Provide details like name, access, versioning enabled - Create
- But creating 100s of buckets will require more time manually. Here we can follow programmatic approach like AWS CLI. We can also talk to AWS services through API programatically/call AWS service using program
- Using scripting we can create multiple resources in AWS in fraction of time. 
  - So we're reducing our effort.
  - But here we need programming knowledge of python or other scripting language. In case of VPC we cannot do using the same
- Here cloud providers give us cloud formation template (CFT) which we can write in JSON/YML. CFT allow to write our infra as code. Here we can write our resources in YML/JSON and apply it to create resources.

- For every tool, there are IaC tools inbuilt like AWS has CFT, Azure has ARM which automate infra reducing efforts of Devops engineer.
- Then why terraform?
  - If different projects in our company are on different cloud platforms. To learn all tools is not possible. So terraform provides universal approach.
  - We can define provider to terrraform where we want to autoate infra AWS/AZURE/GCP. Terraform knowledge is enough to create resources on different cloud platforms
  - Terraform uses API as a code where it directly talk to cloud provider APIs. Using HCL language code is converted to required cloud provider APIs, then terraform applies APIs to create infra
  - Thats why terraform is also called as "API as a Code"
 
-------------------------------------------------------------

Installation of Terraform
-
- Install terraform. Go to codespaces and create one. Codespace is just like a VM which provided by github.
- We can install Terraform and AWS in our github codespace

![image](https://github.com/user-attachments/assets/3f4ffcfd-cce8-4368-ad19-04997a540ecc)
![image](https://github.com/user-attachments/assets/41d0ede1-0c7c-45d9-abbb-99f9b0f49e6e)

- Add dev container config files - Modify active config - Seach terraform - Select the verified one - Ok - Keep defaults

![image](https://github.com/user-attachments/assets/6e6fa30a-38da-4caf-be24-00b5b8a05b3a)
![image](https://github.com/user-attachments/assets/a375d58e-3448-4547-a99a-75cb3eb61b4c)

- Now we can see new file added devcontainer.json

![image](https://github.com/user-attachments/assets/576bb366-7bd9-4628-9fcb-63f843739a22)


- Now install AWS.
  - Add dev container config files - Modify active config - Seach AWS - Select the verified one - Ok - Keep defaults
 
![image](https://github.com/user-attachments/assets/8b8e3db3-8f3f-41b0-8b9f-63208d774be7)

- Now search for "> rebuild " - Rebuild containers. Here we get container in which terraform and AWS installed

![image](https://github.com/user-attachments/assets/e3e4f9f8-95d5-450b-9819-636efd8a22b2)

- Now if we see terminal for terraform and AWS :-

![image](https://github.com/user-attachments/assets/38dbfe85-7118-45d8-b17d-1465761951a3)

-------------------------------------------------------------

Configure AWS with CLI
-
- Go to root account of AWS - Security creds - Get Access keys details by creating new one

![image](https://github.com/user-attachments/assets/2c09bb02-9e1c-4e0c-a056-325d7eec6c68)
![image](https://github.com/user-attachments/assets/48298cdf-428a-45ca-bf45-1f0016940934)

- Now we can say our GitHub codespace is able to authenticate with AWS
- To cross verify we can create resources on AWS UI and check with Codespaces CLI

-------------------------------------------------------------

Configure AWS for terraform
-
- Create main.tf like below for EC2
  - Here we provide provider name and region for the same i.e provider configuration. Location where to autonate the infrastructure. This verifies terraform has access to AWS or not
  - Now we have to provide resources which we need to create below. Provide name of resource, image to be used, instance type
  - We can also take the syntax from Hashicorp documentation.

![image](https://github.com/user-attachments/assets/ac8def93-c25b-4105-a4a6-c3a5cc508ac0)
![image](https://github.com/user-attachments/assets/6fdf43d6-9a8d-4273-a216-293fb8e49090)

- Now we've to run terraform commands which help us to create infra
  - **terraform init** :- To initialize the configuration. Means it will read tf files and will fetch the defined cloud provider credentials. Here we need to go to right directory (day 1 :- cd command) so that it will initialize terraform.
    - This will initialize provider plugins which reads from tf files about which cloud provider to use.

  ![image](https://github.com/user-attachments/assets/97621001-fdbb-431e-9ed6-a4b9b67322be)

  - **terraform plan** :- just like dry run before creating infrastructure we can use this command to see what its going to create
    - It will give us all info of the resource we're creating
 
  ![image](https://github.com/user-attachments/assets/d14b0d6b-1330-46eb-bf7b-804d18873c31)

  - **terraform apply** :- to apply the configuration
    - We can see iur resource got created and also check the same in AWS UI
 
![image](https://github.com/user-attachments/assets/70c412c0-bc6b-48ed-a7b1-e866e265590b)
![image](https://github.com/user-attachments/assets/dc2beacb-fc4b-4999-a7a2-0f0de7a8166a)

- We can also add subnet ID in tf file to attach EC2 to specific subnet

![image](https://github.com/user-attachments/assets/5962c393-7a7b-4135-b400-1443f68c9fd3)

- Now install hashicorp terraform and hashicorp hcl in codespace

![image](https://github.com/user-attachments/assets/1296a834-a152-48bf-a492-0e3bd71c180c)
![image](https://github.com/user-attachments/assets/5a3b996c-0c9c-4a8d-bec2-30b3aa6b60d2)

- We can also add key-value pair which is used to login to the instance

![image](https://github.com/user-attachments/assets/7f1483fc-fbd6-40c6-9403-00ab80491faf)


 
- If any of the field in tf file like ami is not present on cloud, resource will not get created.

