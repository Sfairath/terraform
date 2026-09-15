resource "yandex_compute_disk" "disk_vm" {
  count = 3
  name     = "disk-${count.index + 1}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size = 10
  image_id = data.yandex_compute_image.ubuntu2604lts.id
}

resource "yandex_compute_instance" "storage" {
  name = "storage"
  hostname = "storage"
  platform_id = "standard-v3"
  zone = "ru-central1-a"

  resources {
    cores = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk{
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu2604lts.id
      size     = 10
      type     = "network-hdd"
    }
  }

  dynamic "secondary_disk" {
    for_each = {for disk in yandex_compute_disk.disk_vm : disk.name => disk}
    content{
      device_name = secondary_disk.value.name
      disk_id = secondary_disk.value.id
      auto_delete = false
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
}