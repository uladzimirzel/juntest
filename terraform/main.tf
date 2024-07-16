terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"
  service_account_key_file = "/root/authorized_key.json"
  cloud_id = "b1g5ek2k5ua5ljdio8qp"
  folder_id = "b1ghe4idec5s333glntf"
}

resource "yandex_compute_instance" "default" {
  name        = "test"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    disk_id = "fhmj7ukjjg1do55f0q3b"
  }

  network_interface {
    index  = 1
    subnet_id = "e9bhb3jm9i37q62jjqbj"
  }

  metadata = {
    foo      = "jenkins"
  }
}

resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-a"
  network_id     = "e9bhb3jm9i37q62jjqbj"
  v4_cidr_blocks = ["10.128.0.0/24"]
}