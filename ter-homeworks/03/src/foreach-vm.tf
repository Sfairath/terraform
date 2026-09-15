variable "foreach_vm" {
  type = list(object({
    vm_name=string,
    cpu=number,
    ram=number,
    disk_volume=number,
    core_fraction=number
  }))
  default = [
    {
      cpu = 2
      core_fraction = 20
      disk_volume = 10
      ram = 2
      vm_name = "foreach-web-1"
    },
    {
      cpu = 2
      core_fraction = 20
      disk_volume = 10
      ram = 2
      vm_name = "foreach-web-2"
    }
  ]
}

resource "yandex_compute_instance" "foreach_vms" {
  for_each = {for vm in var.foreach_vm : vm.vm_name => vm}

  name = each.value.vm_name
  hostname = each.value.vm_name
  platform_id = "standard-v3"
  zone = "ru-central1-a"

  resources{
    cores = each.value.cpu
    core_fraction = each.value.core_fraction
    memory = each.value.ram
    
  }

  boot_disk{
    initialize_params{
      name     = "ubuntu2604-${each.value.vm_name}"
      type     = "network-hdd"
      size = each.value.disk_volume
      image_id = data.yandex_compute_image.ubuntu2604lts.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}