resource "local_file" "ansible_inventory" {
  depends_on = [
    yandex_compute_instance.count_vms,
    yandex_compute_instance.foreach_vms,
    yandex_compute_instance.storage
  ]

  content = templatefile(
    "${path.module}/inventory.tftpl",
    {
      count_vms = yandex_compute_instance.count_vms,
      foreach_vms = yandex_compute_instance.foreach_vms,
      storage = yandex_compute_instance.storage
    }
  )

  filename = "${path.module}/ansible/inventory.ini"
}