data "cloudflare_zone" "main" {
  name = var.domain
}

# 複数のレコード値を持つエントリを展開
locals {
  dns_records_expanded = flatten([
    for dns_record in var.dns_records : [
      for idx, record in dns_record.records : {
        key   = "${dns_record.name}_${dns_record.type}_${idx}"
        name  = dns_record.name
        type  = dns_record.type
        ttl   = dns_record.ttl
        value = record
      }
    ]
  ])
}

resource "cloudflare_record" "main" {
  for_each = {
    for record in local.dns_records_expanded : record.key => record
  }

  zone_id = data.cloudflare_zone.main.id
  # CloudFlare APIはレコード名を短縮形で保存する
  # ルートドメイン（k2ss.info）の場合: FQDNのまま
  # それ以外（www.k2ss.info, *.k2ss.info など）: 短縮形（www, * など）
  name = each.value.name == var.domain ? var.domain : replace(each.value.name, ".${var.domain}", "")
  type = each.value.type
  ttl  = each.value.ttl

  # MXレコードの場合
  priority = each.value.type == "MX" ? tonumber(split(" ", each.value.value)[0]) : null
  content  = each.value.type == "MX" ? split(" ", each.value.value)[1] : each.value.value

  # プロキシ設定（Aレコード以外はDNS Onlyにする）
  # ワイルドカードレコードはプロキシできない
  proxied = false
}

resource "cloudflare_record" "sub_domains" {
  for_each = { for sub_domain in var.sub_domains : sub_domain.name => sub_domain }

  zone_id = data.cloudflare_zone.main.id
  name    = each.value.name
  type    = "A"
  content = each.value.records[0]
  ttl     = 1    # プロキシ有効時はCloudFlareが自動管理するため1にする
  proxied = true # CloudFlareのプロキシを有効化してHTTPS終端
}
