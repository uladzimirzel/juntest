provider "yandex" {
  zone                     = "ru-central1-a"
  service_account_key_file = "/root/authorized_key.json"
  cloud_id                 = "b1g5ek2k5ua5ljdio8qp"
  folder_id                = "b1ghe4idec5s333glntf"
}

resource "yandex_vpc_network" "test-vpc" {
  name = "test"
}

resource "yandex_vpc_subnet" "test-subnet-a" {
  network_id = "${yandex_vpc_network.test-vpc.id}"
  v4_cidr_block = ["10.2.0.0/16"]
}