###cloud vars


# variable "cloud_id" {
#   type        = string
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
# }

variable "folder_id" {
  type        = string
  default = "b1gs19n45ufb8fljjffi"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBghlMW0dya5bZ5e1mA/1cnWuaHNq0CjkISp2iFAZlQ7 sfairath@DESKTOP-SQRCHMQ"
#   description = "ssh-keygen -t ed25519"
# }

#task vars
variable "image_family" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "subnet_name" {
  type = string
  default = "develop"
}

variable "vm_web_name" {
  type = string
  default = "web" #"netology-develop-platform-web"  
}

variable "vm_web_platform" {
  type = string
  default = "standard-v3"
}

# variable "vm_web_cores" {
#   type = number
#   default = 2
# }

# variable "vm_web_ram" {
#   type = number
#   default = 2
# }

# variable "vm_web_fraction" {
#   type = number
#   default = 20
# }

#map
variable "vms_resources" {
  type = map(object({
    cores = number
    ram = number
    core_fraction = number
  }))
  default = {
    web = {
      cores = 2
      ram = 1
      core_fraction = 20
    }

    db = {
      cores = 2
      ram = 1
      core_fraction = 20
    }
  }
}

#matadata map
variable "vm_metadata" {
  type = map(object({
    serial-port-enable = number
    ssh-keys           = string
  }))
  default = {
    default = {
      serial-port-enable = 1
      ssh-keys           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBghlMW0dya5bZ5e1mA/1cnWuaHNq0CjkISp2iFAZlQ7 sfairath@DESKTOP-SQRCHMQ"
    }
  }
}