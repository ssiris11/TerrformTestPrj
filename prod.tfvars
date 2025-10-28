variable "prefix" {
  type    = string
  default = "prodaks"
}

variable "location" {
  type    = string
  default = "northeurope"
}

variable "tags" {
  type = map(string)
  default = {
    project = "terraform-aks"
    env     = "prod"
  }
}
