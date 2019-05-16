What's Terraform?
------------
Simple and Powerful

HashiCorp Terraform enables you to safely and predictably create, change, and improve infrastructure. It is an open source tool that codifies APIs into declarative configuration files that can be shared amongst team members, treated as code, edited, reviewed, and versioned.


Objective
------------
Share Terraform custom modules with the community with the following guidelines :
-	a module is dedicated to one action : create network interfaces, create an Azure recovery vault, ...
-	a module doesn't contain any static values
-	a module is called using variables



Usage
-----
The following sample will launch all the modules to show the reader how they are called.
My advice is that the reader pick up the module he wants and calls it how it's shown in the root "main.tf" file.

With your Terraform template created, the first step is to initialize Terraform. 
This step ensures that Terraform has all the prerequisites to build your template in Azure.

```hcl

terraform init -backend-config="backend-smz-sand1.tfvars" -backend-config="secret/backend-smz-sand1.tfvars" -reconfigure

```

The next step is to have Terraform review and validate the template. 
This step compares the requested resources to the state information saved by Terraform and then outputs the planned execution. Resources are not created in Azure.
```hcl

terraform plan -var-file="main-smz-sand1.tfvars" -var-file="secret/main-smz-sand1.tfvars"

```

If all is ok with the proposal you can now apply the configuration.
```hcl

terraform apply -var-file="main-smz-sand1.tfvars" -var-file="secret/main-smz-sand1.tfvars"

```
