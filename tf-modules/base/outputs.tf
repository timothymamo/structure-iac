output "cloudresourcemanager" {
  description = "Cloud Resource Manager API which is enabled to manage APIs"
  value       = google_project_service.cloudresourcemanager
}

output "nat" {
  description = "NAT router enabling internet access to private subnets/clusters"
  value       = google_compute_router_nat.nat
}

output "ingress_static_ip" {
  description = "Static IP address for the ingress controller"
  value       = google_compute_address.static_ip.address
}