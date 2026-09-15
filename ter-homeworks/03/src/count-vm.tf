data "yandex_compute_image" "ubuntu2604lts" {
  family = "ubuntu-2604-lts"
}

resource "yandex_compute_instance" "count_vms" {
  count = 2
  name = "web-${count.index + 1}"
  hostname = "web-${count.index + 1}"
  platform_id = "standard-v3"
  zone = "ru-central1-a"

  resources{
    cores = 2
    core_fraction = 20
    memory = 2
    
  }

  boot_disk{
    initialize_params{
      name     = "ubuntu2604-web-${count.index + 1}"
      type     = "network-hdd"
      size = 10
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

  depends_on = [yandex_compute_instance.foreach_vms]
}