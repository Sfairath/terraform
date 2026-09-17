#db variables
variable "vm_db_name" {
  type = string
  default = "db"
}

variable "vm_db_platform" {
  type = string
  default = "standard-v3"
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

resource "yandex_compute_instance" "db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].ram
    core_fraction = var.vms_resources["db"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = var.vm_metadata["default"]

}