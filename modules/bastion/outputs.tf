output "lb_ip" {
  value = metal_device.lb.access_public_ipv4
}

output "lb_priv_ip" {
  value = metal_device.lb.access_private_ipv4
}

output "finished" {
  depends_on = [
    null_resource.ipxe_files,
    null_resource.dircheck,
    null_resource.ocp_install_ignition,
    null_resource.ignition_append_files,
  ]
  value = "Loadbalancer provisioning finished."
}

