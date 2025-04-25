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
- 

