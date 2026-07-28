resource "yandex_vpc_network" "main" {
  name = "main-net"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public-subnet"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_subnet" "private1" {
  name           = "private-subnet1"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.0.5.0/24"]
}

resource "yandex_vpc_subnet" "private2" {
  name           = "private-subnet2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.0.3.0/24"]
}

resource "yandex_vpc_gateway" "nat" {
  name      = "nat-gateway"
  folder_id = var.folder_id

  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "private_rt" {
  name       = "private-route-table"
  network_id = yandex_vpc_network.main.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat.id
  }
}

resource "yandex_vpc_subnet" "private1_with_rt" {
  name           = "private-subnet1-with-rt"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.0.6.0/24"]
  route_table_id = yandex_vpc_route_table.private_rt.id
}

resource "yandex_vpc_subnet" "private2_with_rt" {
  name           = "private-subnet2-with-rt"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.0.7.0/24"]
  route_table_id = yandex_vpc_route_table.private_rt.id
}
