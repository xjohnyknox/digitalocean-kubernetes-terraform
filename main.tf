terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
#variable "token" {
#  default = ""
#}

variable "do_token" {

}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}


variable "region" {
  # `doctl kubernetes options regions` for full list
  default = "nyc1"
}

resource "digitalocean_project" "k8s-practices" {
  name        = "k8s-practices"
  description = "This is a test environment for my personal stuff"
  purpose     = "Class project / Educational purposes"
  environment = "Development"
  resources   = [digitalocean_kubernetes_cluster.practice-k8s-cluster.urn]

}

resource "digitalocean_kubernetes_cluster" "practice-k8s-cluster" {
  name    = "practice-k8s-cluster"
  region  = var.region
  version = "1.21.9-do.0"

  node_pool {
    name       = "worker-pool-mytest"
    size       = "s-1vcpu-2gb"
    node_count = 2
    auto_scale = false
  }
  tags = ["testanddestroy", "created_by_terraform"]
}
output "cluster-id" {
  value = digitalocean_kubernetes_cluster.practice-k8s-cluster.id
}

output "cluster-ip" {
  value = digitalocean_kubernetes_cluster.practice-k8s-cluster.ipv4_address
}
