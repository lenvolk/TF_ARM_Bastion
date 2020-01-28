# **ADO - Terraform**


This repo is meant as a template for starting Azure DevOps deployments using terraform. The process is orchestrated through **Azure DevOps (ADO) pipelines**. The provided shell scripts will create a storage account to keep the terraform remote state. 

## Setup the Azure DevOps environment

Follow the step below to setup your environment prior to runnig the Azure DevOps pipelines.

1. Create an Azure **Service connection** in ADO.

2. Create a **Variable group** in the ADO pipeline library with the following variables:
    - azure_sub (should be set to the name of the connection created above)
    - cluster_name (only use small caps and no special characters)
    - env

3. Add **(env).auto.tfvars** as a Secure file in the pipeline library and make sure to select the checkbox "Authorize for use in all pipelines". The following variables must be set in this file, where the ARM variables can be created following these [instructions](https://www.terraform.io/docs/providers/azurerm/auth/service_principal_client_secret.html).  

    ```bash
    ARM_CLIENT_ID=""
    ARM_CLIENT_SECRET=""
    ```

You can now create a pipeline using the azure-pipelines.yml in the ADO portal.  Make sure to have the preview feature allowing multi-stage builds turned on.

4. Check if the **Bastion feature has been registered**
    - Connect-AzAccount
    - get-azproviderfeature -listavailable | Where-Object {$_.FeatureName -eq "AllowBastionHost"}

5. Check **Bastion Security and ArmTemplate**
    - [NSG](https://docs.microsoft.com/en-us/azure/bastion/bastion-nsg)
    - [QuickStartTemplate](https://github.com/Azure/azure-quickstart-templates/tree/master/101-azure-bastion)

6. Check **TF Provider**
    - [TFprovider](https://github.com/terraform-providers/terraform-provider-azurerm/blob/master/CHANGELOG.md)
7. Check **azdo-pieline-examples, state file best practice by Matt Mencel**
    - [blog](https://medium.com/@matt_89326/terraform-plan-with-azure-devops-yaml-pipelines-part-1-927a6725a1c9)
    - [repo](https://github.com/MattMencel/azdo-pipeline-examples)

8. Check **TF-Projects-repos**
    - [repo](https://github.com/aztfmod)

9. Check **TF Best Practice**
    - [bio](https://mvp.microsoft.com/fr-fr/PublicProfile/5003548?fullName=James%20Dumont%20le%20Douarec)
    - [repo](https://jamesdld.github.io/terraform/Best-Practice/)

10. Check **TF Variables**
    - [variables](https://upcloud.com/community/tutorials/terraform-variables/)

11. Check **TF Governance by Ricardo Machado**
    - [variables](https://github.com/lenvolk/azuregovernance)