# Terraform Modules

- Our organization has million lines of source code written in java with monolith architecture.
- If there is a bug in app, we might face below challenges in monolith architecture:-
  - For a new person to locate is is difficult.
  - Also there will be lack of ownership as we dont know who developed the code/function logic.
  - Maintenance will also be very difficult in this case as during updates we need to ensure there are no security vulnerabilities.
  - We also need to deploy entire app so testing will also be difficult as we dont know which part to test
 
- Thats why industry has moved to Microservices architecture. Here in terraform its related in below mentioned way

- In terraform, there will be one provider we need to update. For the development team we might need to create lot of resources like VPC, EC2, LB, Lambda, S3. If we try to put all these things in one single terraform project, project might end up like monolith project as we have everything in one terraform project
  - Here if we found bug in project, new person cant locate it
  - Also we dont know who owns the file/change
  - To maintain terraform project is also a headache here
  - Testing will also be difficult due to single project package
 
- If we have written logic for VPC, S3, EC2, LB in main.tf file and we need to fix a bug related to EC2. So devops team will create PR in Git repo addressing changes for EC2.
- So its important not to create everything in one single take. As devops, we will follow Modular approach here which is called as "Modules" in terraform

- Modules have below advantages:-
  - Modularity :- Modules allow to break down our infra configuration into smaller components
  - Reusability :- Write EC2 as module and we can do maintenance easily with taking ownership of resources. We can use module written and provide to other teams as well or other projects
  - Versioning and maintenance :- Modules have versioning to manage updates and changes
  - Abstraction :- Modules can abstract complexity of underlying resources
  - Documentation :- 
  - Scalability :- As your infrastructure grows, modules provide a scalable approach to managing complexity
  - Security :- Modules can encapsulate security and compliance best practices.

--------------------------------------------------------------------------------------

 
