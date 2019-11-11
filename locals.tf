locals {
  instance = "${var.client_name}-${var.environment}"
  fullname = "${var.client_name}-${var.environment}-web-kiosk-redis"
  part_of = "web-kiosk"
  image = "redis:${var.app_version}"
}
