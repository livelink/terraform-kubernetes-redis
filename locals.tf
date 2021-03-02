locals {
  instance = "${var.client_name}-${var.environment}"
  fullname = "${local.instance}-${local.part_of}-redis-${var.service}"
  part_of  = var.part_of
  image    = "redis:${var.app_version}"
}
