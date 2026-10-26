output "storage_blob_id" {
  description = "Azure resource ID of the uploaded blob."
  value       = azurerm_storage_blob.example.id
}

output "storage_blob_url" {
  description = "URL of the uploaded blob. The container is private, so the URL is not publicly readable without authorization."
  value       = azurerm_storage_blob.example.url
}
