terraform {
  required_providers {
     kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.31.0"
    }
  }
}
provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

# provider "kubernetes"{
#   host = google_container_cluster.default.endpoint
#   token = data.google_client_config.current.access_token
#   client_certifiate = base64code(google_container_cluster.default.master_auth[0].client_certificate)
#   cleint_key = base64code(google_container_cluster.default.master_auth[0].client_key)
#   cluster_ca_certificate = base64code(base64code(google_container_cluster.default.master_auth[0].cluster_ca_certificate))
# }