
data "google_client_config" "current" {}

data "google_container_engine_versions" "default" {
  location = "region=europe-central2"
}

resource "google_container_cluster" "primary" {
  name               = "my-gke-cluster"
  location           = "region=europe-central2"
  remove_default_node_pool = true
  initial_node_count = 1
  min_master_version = data.google_container_engine_versions.default.latest_master_version
  network            = "default"

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 32
  }
}

resource "google_container_node_pool" "default" {
  cluster    = google_container_cluster.default.name
  location   = google_container_cluster.default.location
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 32

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
}
