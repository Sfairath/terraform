#web variables
variable "vm_web_name" {
  type = string
  default = "web" #"netology-develop-platform-web"  
}

variable "vm_web_platform" {
  type = string
  default = "standard-v3"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "subnet_name" {
  type = string
  default = "develop"
}

#db variables
variable "vm_db_name" {
  type = string
  default = "db"
}

variable "vm_db_platform" {
  type = string
  default = "standard-v3"
}

variable "db_subnet" {
  type = string
  default = "db_develop"
}

variable "vm_db_zone" {
  type = string
  default = "ru-central1-b"
}

variable "db_cidr" {
  type = list(string)
  default =  ["10.0.2.0/24"]
}
# variable "vm_db_cores" {
#   type = number
#   default = 2
# }

# variable "vm_db_ram" {
#   type = number
#   default = 1
# }

# variable "vm_db_fraction" {
#   type = number
#   default = 20
# }

resource "yandex_vpc_subnet" "db_develop" {
  name           = var.db_subnet
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.db_cidr
}