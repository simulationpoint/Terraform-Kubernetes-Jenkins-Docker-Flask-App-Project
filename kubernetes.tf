terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

variable "host" {
  type = string
}

variable "client_certificate" {
  type = string
}

variable "client_key" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

provider "kubernetes" {
  config_path = "~/.kube/config"

}

resource "kubernetes_deployment" "flask" {
  metadata {
    name = "flask-deployment"
    labels = {
      App = "Scalableflask"
    }
  }

  spec {
    replicas = 5
    selector {
      match_labels = {
        App = "Scalableflask"
      }
    }
    template {
      metadata {
        labels = {
          App = "Scalableflask"
        }
      }
      spec {
        container {
          image = "211896/terraform-flask-app"
          name  = "flaskapp"

          port {
            container_port = 9090
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "flask" {
  metadata {
    name = "flask-service"
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