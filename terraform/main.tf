terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "sf-project9"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd8q9honj0ga5pjdkk0u"
      size     = 20
    }
  }

  network_interface {
    ip_address = "10.128.0.32"
    subnet_id  = "e9b641h3qponppitdva6"
    nat        = true
    ipv6       = false
  }

  metadata = {
    ssh-keys = "user:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "local_file" "hosts_ini" {
  content = templatefile("../ansible/hosts.tpl", {
    sf-project9 = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
  })
  filename   = "../ansible/hosts.ini"
  depends_on = [yandex_compute_instance.vm-1]
}

