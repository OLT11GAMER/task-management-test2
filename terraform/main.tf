
resource "google_container_cluster" "primary" {
  name               = "my-gke-cluster"
  location           = "europe-west4"
  initial_node_count = 1

  node_config {
    machine_type = "e2-medium"
  }

  # For public access, configure firewall rules and network settings accordingly
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  name       = "primary-node-pool"
  node_count = 1

  node_config {
    machine_type = "e2-medium"
  }
}

data "google_client_config" "default" {}
