# Terraform State

- Statefile is a heart of terraform using which terraform will record or store info about infrastructure it has created
- In our terraform project we've written logic for EC2 creation. After applying EC2 will get created. Along with creating resource, terraform will also store info in state file.

- What is terraform doesnt store the info :-
  - If we need to modify EC2 after some days, like adding tag to EC2 along with type and ami.
  - So we'll also provide tag to resource block. If there is no state file, terraform will not understand that it has already created instance with same name. So EC2 with same name is created which is not expected.
  - State file, when we execute apply terraform will go to state file before applying and check what infrastructure is already created and what new it has to create.
  - So using state file it will compare the difference (tag). Here in our case terraform just need to update tag of EC2
 
  - If there is no state file, terraform will not know it has to update infrastructure rather than creating new one.
 
  - When we run terraform destroy, it will again check state file what is created and tell user what it is destroying before prompting for input "yes"
 
- In short state file records infrastructure already created, help to update existing, destroy existing infrastructure as well.

- **Disadvantages**
  - Any action performed using terraform is recorded in state file. But if we dont want to store some sensitive info (passsword) in state file, by default terraform doesnt promote it. So who has access to infrastructure where we're storing project can access the sensitive infoas well
    
