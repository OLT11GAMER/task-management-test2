resource "kubernetes_deployment" "frontend" {
  metadata {
    name      = "frontend-deployment"
    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend"
          image = var.container_image

          port {
            container_port = 8080
          }

          env_from {
            secret_ref {
              name = "frontend-secrets"
            }
          }

          liveness_probe {
            http_get {
              path = "/healthz"
              port = 80
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/readiness"
              port = 8080
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          startup_probe {
            http_get {
              path = "/startup"
              port = 80
            }
            failure_threshold = 30
            period_seconds    = 10
          }
        }
      }
    }
  }
}

# resource "kubernetes_deployment" "name"{
#     metadata{
#         name = "tma-front"
#         labels = {
#             "type" = "frontend"
#             "app" = "nodeapp"
#         }
#     }
#     spec {
#         replicas = 1
#         selector{
#             match_labels = {
#                 "type" = "frontend"
#                 "app"  = "nodeapp"
#             } 
#         }
#         template {
#             metadata { 
#                 name = "tma-front"
#                 labels = {
#                   "type" = "frontend"
#                   "app"  = "nodeapp"
#                 }
#             }
#             spec{
#                 container {
#                     name = "tma_front_image"
#                     image = var.container_image
#                     port {
#                         container_port = 80
#                     }
#                 }
#             }
#         }
#     }
# }
# resource "google-compute_address" "default"{ 
#     name = "ipforservice"
#     region = var.region

# }
# resource "kubernetes_service" "name" {
#     metadata {
#         name = "nodeapp-lb-service"
    
#     spec{
#         type = "LoadBalancer"
#         load_balancer_ip = google_compute_address.default.address
#         port{
#             port = 80
#             target_port = 80
#         }
#         selector = {
#             "type" = "frontend"
#             "app"  = "nodeapp"
#         }
#     }
# }