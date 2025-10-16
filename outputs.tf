output "kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}

output "acr_login_server" {
  value = module.acr.login_server
}
