# Creating an Azure Storage Container and Uploading a Blob

This task involves defining additional resources, organizing the Terraform code into multiple files, and using variables and outputs.

## Prerequisites

- Basic understanding of Terraform and Azure.
- Terraform installed on your machine.
- Azure CLI installed and configured.

## Hands-on Task: Working with Terraform — Advanced Configuration

1. Fork this repository.
2. Create an Azure Storage Container.
3. Define a Storage Blob for the given Container.
4. Define a variable for `resource_group_name`, `location`, `storage_account_name`, `container_name`, and `blob_name` in a `variables.tf` file.
5. Move provider code from `main.tf` to `provider.tf`.
6. Provide the ID of the storage blob and the URL of the blob in `outputs.tf`.
7. Archive the directory with Terraform code.
8. Define the archive as a source in the storage blob section.
9. Plan and apply Terraform changes using the `tfplan` file.

## Implemented solution

The configuration is split by responsibility:

- `provider.tf` pins Terraform providers and configures AzureRM.
- `variables.tf` declares and validates all required input values.
- `main.tf` creates the resource group, storage account, private container,
  ZIP archive, and blob.
- `outputs.tf` prints the blob resource ID and URL after deployment.
- `terraform.tfvars.example` is a safe template for local values.

The generated ZIP excludes Git history, Terraform state, downloaded providers,
the saved plan, and the ZIP itself. The container is private; the output URL
identifies the blob but does not make it anonymously downloadable.

## Run the solution

Azure CLI must be installed and authenticated before running Terraform:

```bash
brew update && brew install azure-cli
az login
az account show
```

Create a local variables file and replace the storage account name with a
globally unique value. Azure Storage account names allow only 3-24 lowercase
letters and numbers.

```bash
cp terraform.tfvars.example terraform.tfvars
```

Then initialize, format, validate, save the plan to `tfplan`, and apply exactly
that saved plan:

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Inspect the requested results with:

```bash
terraform output storage_blob_id
terraform output storage_blob_url
```

When the exercise is finished, remove the Azure resources to avoid unexpected
costs:

```bash
terraform destroy
```

## Git workflow

Create a branch from the current work, review the changes, and commit only the
project files (local values, state, plans, and the generated ZIP are ignored):

```bash
git switch -c solution/terraform-storage-blob
git status
git diff
git add .gitignore .terraform.lock.hcl README.md main.tf outputs.tf provider.tf terraform.tfvars.example variables.tf
git commit -m "Complete Terraform storage blob task"
git push -u origin solution/terraform-storage-blob
```

After pushing, open the repository on GitHub and create a pull request from
`solution/terraform-storage-blob` into `main`.
