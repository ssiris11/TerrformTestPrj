variable "prefix" {
  type    = string
  default = "demoaks"
}

variable "location" {
  type    = string
  default = "northeurope"
}

variable "tags" {
  type = map(string)
  default = {
    project = "terraform-aks"
    env     = "dev"
  }
}
