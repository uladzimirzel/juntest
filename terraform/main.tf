provider "yandex" {
  zone = "ru-central1-a"
  service_account_key_file = "~/authorized_key.json"
  cloud_id = "b1g5ek2k5ua5ljdio8qp"
  folder_id = "b1ghe4idec5s333glntf"
}

resource "yandex_compute_disk" "boot-disk" {
  name     = "boot-disk"
  type     = "network-ssd"
  zone     = "ru-central1-a"
  size     = "15"
  image_id = "fd8t24r7o6m7fdvlp47l"
}

resource "yandex_compute_instance" "vm-1" {
  name                      = "linux-vm"
  allow_stopping_for_update = true
  platform_id               = "standard-v1"
  zone                      = "ru-central1-a"

  resources {
    cores  = "2"
    memory = "2"
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default-ru-central1-a.id}"
    nat       = true
  }
}

resource "yandex_vpc_network" "default" {
  name = "default"
}

resource "yandex_vpc_subnet" "default-ru-central1-a" {
  name           = "default-ru-central1-a"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.128.0.0/24"]
  network_id     = "${yandex_vpc_network.default.id}"
}
