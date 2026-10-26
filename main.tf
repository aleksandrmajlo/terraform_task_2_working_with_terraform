resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

data "archive_file" "terraform_code" {
  type        = "zip"
  source_dir  = path.module
  output_path = "${path.module}/terraform-code.zip"

  # Do not put local Terraform data, Git history, or the generated ZIP
  # inside the ZIP itself.
  excludes = [
    ".git/**",
    ".terraform/**",
    ".terraform.lock.hcl",
    ".terraform.tfstate.lock.info",
    ".DS_Store",
    "terraform.tfstate",
    "terraform.tfstate.*",
    "terraform.tfvars",
    "*.auto.tfvars",
    "tfplan",
    "terraform-code.zip",
  ]
}

resource "azurerm_storage_blob" "example" {
  name                   = var.blob_name
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = data.archive_file.terraform_code.output_path
  content_md5            = data.archive_file.terraform_code.output_md5
  content_type           = "application/zip"
}
