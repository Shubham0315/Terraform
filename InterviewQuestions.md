Features of terraform
-
- Infrastructure as a Code  :- Define infra using declarative config using HCL which talks to cloud provider APIs and create resources
- Executiion plan (terraform plan) :- Shows exactly what terraform will do before applying any changes, to understand the impact of code changes
- Automated provisioning (terraform apply) :- Auto provisions, updates and deletes resources based on config files of resources
- State management :- Maintains state file which records currect state of infrastructure. Enables resource tracking and incremental changes
- Multi cloud support
- Modular and reusable configurations using modules

Terraform provider
-
- While creating resources using terraform, we've to mention provider block with region which states on which cloud provider we need to create resources
- Provider acts as a plugin which will first authenticate with cloud and enable resource provisioning
- 2 types of providers
  - Multi region :- Write 2 provider blocks with region and alias defined for each (provider = "aws.$alias"). Using alias terraform understand in which region to create resources
  - Multi cloud :- Define 2 different providers in provider.tf file and write resources in main.tf
 
<img width="1593" height="599" alt="image" src="https://github.com/user-attachments/assets/284e3566-43ee-4173-9b8f-7606dac2efb6" />

<img width="1611" height="402" alt="image" src="https://github.com/user-attachments/assets/30131a99-23c7-4f04-a8b9-ab79d397dfc4" />

How terraform manage dependencies?
- 
- Terraform auto manages dependencies between resources using **dependency graph** based on how resources reference each other.
- **Implicit dependencies** :- TF builds dependency graph by analyzing references between resources. It checks instance depends on subnet as it references its id, so it creates subnet and then EC2
- **Explicit dependencies** :- When dependencies are not obvious through references. We can use "depends_on" here to explicitly tell terraform what to wait for . In below SS, terraform will wait for bucket to be created

<img width="1603" height="509" alt="image" src="https://github.com/user-attachments/assets/3c9ac565-0750-407c-a2bb-39133942d4e4" />


What is state file in terraform and why it is important to manage it?
-
- Statefils is a heart of terraform which records and store the info about the infrastructure create on cloud provider.
- If we've to update resources and we dont have statefile, terraform will not understand it has already created resource
- When we apply config, terraform checks statefile. Sees what is created and what new has to be created (update existing resources). So it compares difference between existing and new resources

How to secure statefile in terraform?
- 
- Statefiles can be secured by storing them in remote backends with proper access controls and encryption like AWS S3 with server-side encryption and access control policies
- Securing statefile is critical as it can contain sensitive information like cloud provider credentials, secrets, tokens.
- So instead of storing locally, use remote backend as it supports encryption at rest, access control, versioning, locking.
- Mostly preferred is AWS S3 + DynamoDB :- Encrypt with SSE/KMS, lock state with dynamoDB

<img width="1247" height="368" alt="image" src="https://github.com/user-attachments/assets/0d2e715e-caa0-4dec-9245-8d6dcc22d93a" />

- This encrypts state in S3, enables state locking via DynamoDB, keeps audit history via versioning
- We can also restrict access to state using IAM policies

- Dont store sensitive data in plain text inside variables or state, use hashicorp vault, external data sources to fetch secrets at runtime, use env variables
- Enable versioning to recover previous state files


Explain terraform modules
-
- It is a reusable, self contained group of resources that encapsulates terraform logic. Modules elp, reuse and scale terraform code efficiently
- Module is just a folder of .tf files. Even our root config is a module
- We use modules due to reusability, maintainability, consistency

- Structure :- modules - Folder - main.tf, variables.tf, outputs.tf

<img width="798" height="735" alt="image" src="https://github.com/user-attachments/assets/7acf5db7-194e-4eca-91e2-966c0f4e41f2" />

<img width="787" height="233" alt="image" src="https://github.com/user-attachments/assets/911ff5fc-370e-4a08-a4c6-7cd853784321" />

- When you call module, terraform loads module code, passes the variables and teats it like part of main config
- Terraform locates module using source (folder path). Variables defined in module are populated. Reads resources files. Resources and created and statefile is updated.

How to define and use variables in terraform?
-
- Variables are used to parameterize things, to pass values to project making config more dynamic, reusable and flexible.
- We can replace hardcoded values with variables. We define them at one place and use them throughout .tf files
- 2 types of variables
  - **Input** :- To pass values to terraform modules or config
  - **Output** :- To print specific values in output once apply command is performed
 
<img width="1258" height="453" alt="image" src="https://github.com/user-attachments/assets/20d5f599-50d3-423e-8eaa-02df019847bb" />


How to import existing resources into terraform?
-
- We can do using "terraform import" command which maps existing resources to terraform resources in state file.
- Command :- **terraform import resourceType.resourceName.resourceID**
- This allows to bring resources created outside terraform under terraform's management without recreating them

What are terraform provisioners?
-
- Provisioners are used to execute scripts or commands on local or remote machine during resource creation or destruction process
- Types
  - **local-exec** :- Runs command on machine where terraform is running. If we just need to print some lines of code in console, we use local exec and it copies output to a file

 <img width="827" height="223" alt="image" src="https://github.com/user-attachments/assets/f9b54f84-6833-484e-92fe-432f41fa3936" />

  - **remote-exec** :- Executes command on remote machine over SSH or WinRM (on EC2)

 <img width="1417" height="415" alt="image" src="https://github.com/user-attachments/assets/0f4858bd-9047-46e1-ac8a-9c61f82dc313" />

  - **file** :- Used to copy/transfer files from local to remote machines

 <img width="560" height="138" alt="image" src="https://github.com/user-attachments/assets/5e43d889-1280-4471-9748-519c5ca8e22d" />


How to handle secrets in terraform?
-
- Avoid hardcoding secrets in .tf files
- Use environment variables storing in tf_var
- Use terraform.tfvars
- Use remote secret managers like hashicorp vault or AWS secrets manager
- State files store secrets in plain text, to secure them use remote backends with encryption like S3+KMS

What is backend in terraform?
-
- Backend mechanism determines how and where terraform stores state file
- Backend = storage + locking + collaboration layer
- Backend matters as terraform stores statefile which tracks real infrastructure. If file is lost, corrupted we can loose track of resources, we risk duplicating or destroying real infra
- If no backend defined, terraform uses local backend by default storing statefile locally.
- Commonly used :- S3 + DynamoDB

How to use conditional expressions in terraform?
-
- Conditionals allow us to make descisions based on variables or resource attributes
- Syntax :- **condition ? true_value : false_value**
- Basically used to assign values based on conditionals using ternary operator

<img width="1007" height="355" alt="image" src="https://github.com/user-attachments/assets/f4c6cdf7-c678-406f-bb14-5f5b858af2f2" />


What is terraform validate?
-
- Used to validate syntax and config of terraform file without creating resources

How to format terraform config files?
-
- Command :- **terraform fmt**
- Auto formats .tf files making code cleaner, easier to read and consistent

How to use loops in terraform?
-
- Terraform supports loops using 2 expressions
  - for loops :- to transform or generate collections
  - for_each / count :- to create multiple resources dynamically
 
What are locals in terraform and how to use them?
-
- locals in terraform are named values or expressions we define once and reuse throughout our configuration.
- They're read only, scoped to module and improve readability, reusability and performance by avoiding repetition of complex expressions
- Define locals in one file and use in main.tf

<img width="896" height="265" alt="image" src="https://github.com/user-attachments/assets/0e70ca78-afe8-4a95-b81f-744e771a8d90" />

<img width="868" height="327" alt="image" src="https://github.com/user-attachments/assets/28bb397d-5fd0-4100-acf1-0557e88de158" />

How to handle module versioning in terraform?
-
- Managed using "version" argument in source attribute of module lock

What is terraform registry?
- 
- Public repository of terraform modules and providers that can be used to discover and use pre-built modules and providers
- Helps to reuse infra code easily, securely and consistently
- We can also publish our own module

Terraform state command
-
- Used to inspect, modify and manage terraform state file which tracks infra
- Use this command carefully as direct state manipulation can lead to broken configs
- terraform state list :- lists all resources in statefile
- terraform state show aws_instance.shubham :- show resource details
- terraform state mv source destination :- move or rename resource
