locals {
  ssh_metadata = "ubuntu:${file(var.public_key_path)}"
}

resource "yandex_compute_instance" "bastion" {
  allow_stopping_for_update = true

  name        = "bastion"
  hostname    = "bastion"
  zone        = var.default_zone
  platform_id = "standard-v1"

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  scheduling_policy {
    preemptible = false
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.bastion_sg.id]
  }

  metadata = {
    ssh-keys = local.ssh_metadata
  }
}

resource "yandex_compute_instance" "web1" {
  allow_stopping_for_update = true

  name        = "web-1"
  hostname    = "web1"
  zone        = var.default_zone
  platform_id = "standard-v1"

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  scheduling_policy {
    preemptible = false
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private1_with_rt.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.web_sg.id]
  }

  metadata = {
    ssh-keys = local.ssh_metadata
  }
}

resource "yandex_compute_instance" "web2" {
  allow_stopping_for_update = true

  name        = "web-2"
  hostname    = "web2"
  zone        = "ru-central1-b"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  scheduling_policy {
    preemptible = false
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private2_with_rt.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.web_sg.id]
  }

  metadata = {
    ssh-keys = local.ssh_metadata
  }
}

resource "yandex_compute_instance" "zabbix" {
  allow_stopping_for_update = true

  name        = "zabbix"
  hostname    = "zabbix"
  zone        = var.default_zone
  platform_id = "standard-v1"

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 4
  }

  scheduling_policy {
    preemptible = false
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = "network-hdd"
      size     = 20
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.zabbix_sg.id]
  }

  metadata = {
    ssh-keys = local.ssh_metadata
  }
}

resource "yandex_compute_instance" "kibana" {
  allow_stopping_for_update = true

  name        = "kibana"
  hostname    = "kibana"
  zone        = var.default_zone
  platform_id = "standard-v1"

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  scheduling_policy {
    preemptible = false
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.kibana_sg.id]
  }

  metadata = {
    ssh-keys = local.ssh_metadata
  }
}

resource "yandex_compute_instance" "elastic" {
  name        = "elastic"
  hostname    = "elastic"
  zone        = var.default_zone
  platform_id = "standard-v1"

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }
  scheduling_policy { preemptible = false }

  network_interface {
    subnet_id = yandex_vpc_subnet.private1.id
    nat       = false
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/volkivskiy/.ssh/id_rsa.pub")}"
  }

  allow_stopping_for_update = true
  }
