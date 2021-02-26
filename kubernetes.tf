terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
   config_path = "~/.kube/config"
}

resource "kubernetes_services" "flask" {
  metadata {
    name = "flask-app"
  }
  spec {
    selector = {
      App = kubernetes_deployment.flask.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30201
      port        = 9090
      target_port = 9090
    }

    type = "NodePort"
  }
}

resource "kubernetes_deployment" "flask" {
  metadata {
    name = "scalable-flask-app"
    labels = {
      App = "ScalableFlaskApp"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableFlaskApp"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableFlaskApp"
        }
      }
      spec {
        container {
          image = "sarankaja/kubesba"
          name  = "flaskApp"

          port {
            container_port = 9090
          }
          resources {
            limits = {
              cpu    = "1"
              memory = "512Mi"
            }
            requests = {
              cpu    = "500m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
}
