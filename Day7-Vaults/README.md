# Terraform Vaults and Secrets Management

- Secrets management is important as we can handle sensitive info like passwords, API tokens, certificates
- Hashicorp vault is most popular choice for secrets management and we can integrate it with Ansible, Terraform, CICD, K8S.
- In vault we can use info related to K8S, storing SSH info.

- Create one EC2 instance named "vault"
  - Copy public IP and go to terminal :- **ssh -i key ubuntu@IP**
  - Run command to update apt package manager and install gpg :- **sudo apt update && sudo apt install gpg**
  - This step is done as vault is not by default available in our package manager on ubuntu. Running above hashicorp vault manager is added to our ubuntu.
  - Download the signing key to a new keyring

![image](https://github.com/user-attachments/assets/55439fab-ac92-46be-9c0a-d2274cc106da)
![image](https://github.com/user-attachments/assets/4a9207e0-2b02-4cbc-82ba-122d44ff9e41)
![image](https://github.com/user-attachments/assets/20718d36-c6d7-40f9-adf6-4c2a282e3d82)
![image](https://github.com/user-attachments/assets/b8844fe0-0857-4e69-a31d-6fa8a2537993)
![image](https://github.com/user-attachments/assets/025935b2-ef27-458b-b14b-33600675bda1)

  - Now add hashicorp repo to ubuntu manager by below command. After adding this repo only, it can install vault on ubuntu machine

![image](https://github.com/user-attachments/assets/0f87bc8d-257f-48d6-be60-7233ed693c57)

  - Now run "sudo apt update" to update repo. Then run "sudo apt install vault" to install vault. To verify vault is installed just run "vault"

![image](https://github.com/user-attachments/assets/957d291c-88f0-46cb-a161-23651d64ca14)
![image](https://github.com/user-attachments/assets/10dba84d-1722-416b-86c2-32c9b80d3c48)

- Now start the vault server. Vault comes in 2 different variations "dev" and "prod" server to start off with
  - We can start off with "dev" but in organization use "prod" one
  - Command to start vault dev server :- **vault server -dev -dev-listen-address="0.0.0.0:8200"**
 
![image](https://github.com/user-attachments/assets/216cce59-b898-438e-9fda-d06921d4d78b)

  - Open another session of EC2 instance as in previous terminal we can keep dev server running and in new one is for our practical demo.
  - Copyu the VAULT_ADDR in output of first terminal and export in another terminal :- export VAULT_ADDR='http://0.0.0.0:8200

![image](https://github.com/user-attachments/assets/64d80fac-082b-46e5-aba5-31ef78422fdf)

  - Now we can access our vault instance by enabling our SGs inside EC2 as by default SGs doesnt allow any external traffic apart from SSH (8200 is port here)
  - Go to security tab in EC2 - Edit inbound config - Add rule as below - Allow any source to access EC2

![image](https://github.com/user-attachments/assets/6bbe3643-08b8-4e56-ae65-0398a78e7336)

  - Now if we try to access publicIP:8200, we can see vault UI

![image](https://github.com/user-attachments/assets/6c1d6b1c-c5b8-4df0-949e-ff255ec16af0)

  - To authenticate, just copy the root token from terminal 1.

![image](https://github.com/user-attachments/assets/27e3d55b-ce3c-43f1-8534-e78d80552194)
![image](https://github.com/user-attachments/assets/7c75a655-a4a2-4dee-8850-88595a73ad2f)


---------------------------------------------------------------------------------------------------------------

We can see options like:-
- Secret engines
- Access
- Policies
- Tools
- Client count

- Secret Engines
  - Diff types of secrets we create in vault.
  - If we've to store TLS based K8S secret then we can use K8S secret engine and to configure it we need to provide K8S cluster details to integrate
  - To store key-value like user and pass, we can use KV option
  - Click on "Enable new engine"
 
  ![image](https://github.com/user-attachments/assets/42980dd2-309e-4d99-938a-83fd7d643e9c)
  ![image](https://github.com/user-attachments/assets/2039fe82-1bb2-4891-9b83-fbf2949fbfa6)

  - We'll use KV here. It asks for path which is to mount vault on EC2. Vault does the encryption for user/pass and even on mount it stores encrypted info. Decrypted info will be on hashicorp vault only. Enable engine
 
![image](https://github.com/user-attachments/assets/4204bc68-ad35-42d8-8984-f10ba5724b14)

  - Now engine is enabled. Now we can create secret. Given name of secret and values of key pair

![image](https://github.com/user-attachments/assets/9835d1c6-a34c-490f-a411-c6d7022b7bc8)

  - We've created secret but nobody has access to it. To grant access to terraform or ansible, we need to create role inside hashicorp vault (similar to IAM role)
  - Here we can create "access". Inside access there are authentication methods as below
  - Most widely used is app role (similar to IAM role)

![image](https://github.com/user-attachments/assets/e2e31771-7afc-4581-8aa1-1b3e9d4c002c)

  - Click on app role and enable method to use approle based authentication. We'll authenticate ansible or terraform using this approle mechanism. But we need to create approle using CLI as UI doesnt support the same
  - Write policy of role to grant access to diff folders or mounts. KV and secret are mounts here in SS. Policy is created with name "terraform"

![image](https://github.com/user-attachments/assets/3e9a6768-151f-4d42-ab9a-23ac1d62a57d)

  - Now in UI we can see terraform has access to KV and Secret both folders

![image](https://github.com/user-attachments/assets/52a006aa-4482-4386-9156-0ee3c9aefa0d)

  - Now to create role, run below

![image](https://github.com/user-attachments/assets/e84c1d54-e034-402c-8459-0ecdb4a39665)

  - Here now we've role id and secret id (access key and secret key in AWS)
  - Command :- **vault read auth/approle/role/terraform/role-id/secret-id**
  - We can retrieve the secrets from vault

![image](https://github.com/user-attachments/assets/240fe419-d61d-48f9-a093-9906f1248cfb)


- Now write terraform project. Create main.tf
  - Write provider as usual. We'll use the password secret as tag value on EC2.
  - Write provider as "vault" for secret maneger. We can create resources in vault or read resources inside vault
  - To create resources we use "resource" keyword. To read resources use keyword "data" (retrieve info)
  -   To authenticate with vault provider, we can use syntax as below. Use documentation
  - Provide EC2 IP. Skip child token is necessary
  - Provide auth method to authenticate with vault. We're using approle here. Provide role id and secret id in parameters

![image](https://github.com/user-attachments/assets/3920da5f-0128-4b1e-bc51-9dbdb6290938)

- To verify authentication is right, go to the folder and run terraform init. We can see its installing the vault

![image](https://github.com/user-attachments/assets/cdbe3686-ad72-449a-b747-0a377171d79e)

  - For authentication, use data keyword to read resources (take syntax from documentation)
  - Here we need to change mount name and name as our requirement. Our mount is "kv" and name of secret is "test-secret" (check in vault page)

![image](https://github.com/user-attachments/assets/62cc8f70-ec81-442d-8b29-7fb8b0293d38)

  - Now to check if authentication is working fine or not. Use terraform apply
  - We can see no resources are created as we're just reading them
  - But if apply is done means hashicorp vault and terraform integration is done

![image](https://github.com/user-attachments/assets/d6f79c10-e657-4524-bcb2-1b5b779e7ae5)

  - Now write EC2 instance logic. Now use the value from vault and upload to EC2 instance
  - Create EC2 resource.
  - Write tags. Take value of tag from vault UI (test-secret)' password as tag. We'll inherit the same from data (read) resource above. We need to retrieve data of "username" from vault (as we just need data of username)

![image](https://github.com/user-attachments/assets/f28b341b-0eba-46e2-9d67-73256863b34c)

  - Now do terraform apply

![image](https://github.com/user-attachments/assets/a0a7d467-f3aa-499c-b3bb-985345bbe01b)

  - Now we can go to AWS UI and see inside EC2 if secret is added - Go to tags inside EC2

![image](https://github.com/user-attachments/assets/a06d0153-feb8-4ca4-b194-64404f7b54a6)

  
  
---------------------------------------------------------------------------------------------------------------

We can also do the same for S3 or other resources
---------------------------------------------------------------------------------------------------------------

Secret ID kabhi bhi change ho skta he. Please take care while running terraform commands

