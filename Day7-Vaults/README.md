# Terraform Vaults and Secrets Management

- Secrets management is important as we can handle sensitive info like passwords, API tokens, certificates
- Hashicorp vault is most popular choice for secrets management and we can integrate it with Ansible, Terraform, CICD, K8S.
- In vault we can use info related to K8S, storing SSH info.

- Create one EC2 instance named "vault"
  - Copy public IP and go to terminal :- **ssh -i key ubuntu@IP**
  - Run :- **sudo apt update && sudo apt install gpg**
  - This step is done as vault is not by default available in our package manager on ubuntu. Running above hashicorp vault manager is added to our ubuntu.
