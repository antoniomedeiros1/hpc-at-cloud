output "public_ip" {
  value = google_compute_address.nfs_static_ip.address
}
