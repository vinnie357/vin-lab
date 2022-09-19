# provider
provider "vsphere" {
  vsphere_server = var.vsphere_vcenter
  user           = var.vsphere_user
  password       = var.vsphere_password

  allow_unverified_ssl = var.vsphere_unverified_ssl
}
# vsphere
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}
resource "vsphere_folder" "folder" {
  path          = var.vsphere_folder
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}
resource "vsphere_folder" "bigip" {
  depends_on    = [vsphere_folder.folder]
  path          = "${var.vsphere_folder}/bigip"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}
resource "vsphere_folder" "voltstack" {
  depends_on    = [vsphere_folder.folder]
  path          = "${var.vsphere_folder}/voltstack"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}
resource "random_password" "bigip_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}
# creds
locals {
  bigip_admin_password = var.bigip_admin_password != "" ? var.bigip_admin_password : random_password.bigip_password.result
  bigip_root_password  = var.bigip_root_password != "" ? var.bigip_root_password : random_password.bigip_password.result
}
# bigips
module "bigip" {
  depends_on           = [vsphere_folder.bigip]
  source               = "git::https://github.com/vinnie357/terraform-vmware-bigip/?ref=main"
  vsphere_datacenter   = data.vsphere_datacenter.dc.id
  instances            = var.instances["vin-lab"]
  bigip_admin_password = local.bigip_admin_password
  bigip_root_password  = local.bigip_root_password
}
// # voltstack site
// module "voltstack-vmware" {
//   depends_on                = [vsphere_folder.voltstack]
//   for_each                  = var.vm_config
//   source                    = "git::https://github.com/vinnie357/terraform-vmware-voltstack/?ref=main"
//   vsphere_datacenter        = var.vsphere_datacenter
//   vsphere_cluster           = each.value.vsphere_cluster
//   vsphere_folder_env        = var.vsphere_folder
//   vsphere_folder_path       = vsphere_folder.voltstack.path
//   vm_domain                 = each.value.vm_domain
//   vm_datastore              = each.value.vm_datastore
//   vm_template               = each.value.vm_template
//   vm_name                   = each.key
//   vm_cpu                    = each.value.vm_cpu
//   vm_ram                    = each.value.vm_ram
//   vm_disk0_size             = each.value.vm_disk0_size
//   vm_networks               = each.value.vm_networks
//   vm_linked_clone           = each.value.vm_linked_clone
//   ves_site_token            = var.ves_site_token
//   ves_cluster_name          = var.ves_cluster_name
//   site_latitude             = var.site_latitude
//   site_longitude            = var.site_longitude
//   ves_hardware              = var.ves_hardware
//   vm_ip                     = each.value.vm_ip
//   vm_dns_0                  = each.value.vm_dns_0
//   vm_dns_1                  = each.value.vm_dns_1
//   default_public_gateway    = each.value.default_public_gateway
//   default_route_destination = each.value.default_route_destination
// }
