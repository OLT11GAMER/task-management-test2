
data "google_client_config" "current" {}

data "google_container_engine_versions" "default" {
  location = "europe-central2"
}

resource "google_container_cluster" "primary" {
  name               = "my-gke-cluster"
  location           = "europe-central2" # Set your preferred region
  initial_node_count = 1
  remove_default_node_pool = true
  
  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }

  network = "default"
  subnetwork = "default"

  ip_allocation_policy {
    use_ip_aliases = true
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  enable_kubernetes_alpha = false

  public_access_cidr_blocks = ["0.0.0.0/0"]
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  name       = "primary-node-pool"
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 32
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
}
