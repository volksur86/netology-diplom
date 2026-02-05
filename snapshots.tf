resource "yandex_compute_snapshot_schedule" "daily_snapshots" {
  name        = "daily-snapshots"
  description = "Ежедневные снапшоты дисков всех сервисов, храним 7 шт."

  folder_id = var.folder_id

  # Какие диски бэкапим
  disk_ids = [
    yandex_compute_instance.web1.boot_disk[0].disk_id,
    yandex_compute_instance.web2.boot_disk[0].disk_id,
    yandex_compute_instance.zabbix.boot_disk[0].disk_id,
    yandex_compute_instance.kibana.boot_disk[0].disk_id,
    yandex_compute_instance.elastic.boot_disk[0].disk_id,
  ]

  # Бэкапим каждый день в 03:00
  schedule_policy {
    expression = "0 3 * * *"
  }

  # Политика хранения: хранить только последние 7 снапшотов на диск
  snapshot_count = 7

  snapshot_spec {
    description = "Autobackup by Terraform snapshot schedule"
    labels = {
      project = "netology-diplom"
      env     = "prod"
      type    = "daily"
    }
  }
}
