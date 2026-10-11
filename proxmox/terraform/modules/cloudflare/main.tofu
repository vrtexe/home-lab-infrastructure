resource "random_bytes" "cloudflare_tunnel_secret" {
  length = 32
}

output "cloudflare_tunnel_secret" {
  value     = random_bytes.cloudflare_tunnel_secret.base64
  sensitive = true
}

resource "kubernetes_secret" "cloudflare_tunnel_secret" {
  metadata {
    name      = "cloudflare-tunnel-secret"
    namespace = "cloudflare"
  }

  data = {
    secret = random_bytes.cloudflare_tunnel_secret.base64
  }
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "cloudflare-tunnel" {
  account_id    = var.cloudflare_account_id
  name          = "cloudflare-vrtexe-tunnel"
  tunnel_secret = random_bytes.cloudflare_tunnel_secret.base64
}

resource "cloudflare_dns_record" "cloud_wildcard_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "*.cloud"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.cloudflare-tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
  ttl     = 1
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "cloudflare_config" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.cloudflare-tunnel.id
  config = {
    ingress = [
      {
        hostname = "*.cloud.vrtexe.com"
        service  = "https://${var.control_plane_ip}:${var.control_plane_port}"
      },
      {
        service = "http_status:404"
      }
    ]
  }
}
