output "nfs_public_ip" {
  value = module.nfs.public_ip
}

output "vm_instance_1_public_ip" {
  value = module.vm-instance-1.public_ip
}

output "vm_instance_2_public_ip" {
  value = module.vm-instance-2.public_ip
}
