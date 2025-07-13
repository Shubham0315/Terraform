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

