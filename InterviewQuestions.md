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
- 
