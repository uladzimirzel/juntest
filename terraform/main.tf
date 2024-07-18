provider "yandex" {
  zone                     = "ru-central1-a"
  service_account_key_file = "/var/jenkins_home/key.json"
  cloud_id                 = "b1g5ek2k5ua5ljdio8qp"
  folder_id                = "b1ghe4idec5s333glntf"
}

resource "yandex_vpc_network" "test-vpc" {
  name = "test"
}

resource "yandex_vpc_subnet" "test-subnet-a" {
  name           = "test-subnet-a"
  v4_cidr_blocks = ["10.146.0.0/24"]
  network_id     = yandex_vpc_network.test-vpc.id
}

resource "yandex_compute_instance" "build" {
  name        = "build"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80bm0rh4rkepi5ksdi"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.test-subnet-a.id}"
    nat = true
  }

  metadata = {
    ssh-keys = "root:${file("~/.ssh/id_ed25519.pub")}"
  }
}