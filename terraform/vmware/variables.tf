#vcenter
variable "vsphere_user" {
  description = "vSphere service account name ex: svc-terraform@domain.com"
}
variable "vsphere_password" {
  description = "vSphere password"
}
variable "vsphere_vcenter" {
  description = "vCenter server FQDN or IP"
}
variable "vsphere_datacenter" {
  description = "vSphere datacenter"
}
variable "vsphere_unverified_ssl" {
  description = "Is the vCenter using a self signed certificate (true/false)"
  default     = "true"
}
variable "vsphere_folder" {
  description = "vSphere folder where resources are created"
}
# bigip credentials
variable "bigip_admin_password" {
  description = "bigip web gui password"
  default     = ""
}
variable "bigip_root_password" {
  description = "bigip ssh password"
  default     = ""
}
# instances
variable "instances" {
  description = "instance configuration"
  default = {
    site = {
      instance01 = {
        # vcenter
        vm_vsphere_datacenter  = "domain.com"
        vm_vsphere_cluster     = "mycomputecluster"
        vm_datastoreName       = "mydatastore"
        vm_folderPath          = "development/bigip/"
        vm_template_bigip_name = "BIGIP-15.1.2-0.0.9.ALL2"
        vm_linked_clone        = false
        # instance
        name         = "bigip-site"
        domain       = "domain.com"
        mgmtIp       = "192.168.20.54"
        mgmt_netmask = "24"
        mgmt_gw      = "192.168.20.254"
        # networks/interfaces
        interface1 = "networkname"
        interface2 = "networkname"
        interface3 = "networkname"
        interface4 = "networkname"
        # atc
        initVersion = "1.3.2"
        doVersion   = "1.23.0"
        as3Version  = "3.30.0"
        tsVersion   = "1.22.0"
        cfVersion   = "1.9.0"
        fastVersion = "1.11.0"
        # none,minimal,nominal,dedicated
        provisioning = <<EOF
        "avr": "none",
        "ltm": "nominal",
        "asm": "none",
        "apm": "none",
        "afm": "none",
        "gtm": "none"
        EOF
        # bigip onboarding
        onboard_log   = "/var/log/startup-script.log"
        license       = "xxx-xxx"
        adminUserName = "admin"
        dnsServerList = <<EOF
        "192.168.2.251",
        "8.8.8.8"
        EOF
        dnsSuffix     = "domain.com"
        ntpServerList = <<EOF
        "0.pool.ntp.org",
        "1.pool.ntp.org",
        "2.pool.ntp.org"
        EOF
        #https://support.f5.com/csp/article/K9098
        timeZone              = "America/New_York"
        vlanExternalInterface = "1.1"
        vlanExternalTagging   = "true"
        vlanExternalTag       = "4094"
        vlanExternalIp        = "192.168.1.54/24"
        vlanInternalInterface = "1.2"
        vlanInternalTagging   = "true"
        vlanInternalTag       = "4093"
        vlanInternalIp        = "192.168.2.54/24"
        vlanHaInterface       = "1.3"
        vlanHaTagging         = "true"
        vlanHaTag             = "4092"
        vlanHaIp              = "192.168.3.54/24"
        externalGateway       = "192.168.1.254"
        internalGateway       = "192.168.2.254"
      }
    }
  }
}
# volterra
variable "ves_site_token" {
  description = "site token to register with"
}
variable "ves_cluster_name" {
  description = "site name in volterra"
}
variable "site_latitude" {
  description = "site latitude"
}
variable "site_longitude" {
  description = "site longitude"
}
variable "ves_hardware" {
  description = "volterra hardware type default vmware-voltstack-combo | vmware-multi-nic-voltstack-combo"
  default     = "vmware-voltstack-combo"
}
// vmware config
variable "vm_config" {
  description = "Map of Vmware config"
  type        = map(any)
  default = {
    voltstack-0 = {
      vm_domain       = "my-domain.com"
      vsphere_cluster = "my-cluster"
      vm_datastore    = "my-datastore1"
      vm_cpu          = "4"
      vm_ram          = "16384"
      vm_disk0_size   = "40"
      vm_networks = {
        eth0 = "192.168.1.0"
        eth1 = "192.168.3.0"
      }
      vm_template = "voltstack-1nic"
      #vm_template         = "voltstack-2nic"
      vm_linked_clone = "false"
      # leave unset for dhcp
      vm_ip                     = ""
      vm_dns_0                  = ""
      vm_dns_1                  = ""
      default_route_destination = ""
      # set for static
      #vm_ip               = "192.168.1.187/24"
      #vm_dns_0            = "192.168.3.1"
      #vm_dns_1            = "192.168.2.251"
      #default_route_destination = "0.0.0.0/0"
      #default_public_gateway    = "192.168.1.254"
    },
    voltstack-1 = {
      vm_domain       = "my-domain.com"
      vsphere_cluster = "my-cluster"
      vm_datastore    = "my-datastore1"
      vm_cpu          = "4"
      vm_ram          = "16384"
      vm_disk0_size   = "40"
      vm_networks = {
        eth0 = "192.168.1.0"
        eth1 = "192.168.3.0"
      }
      vm_template = "voltstack-1nic"
      #vm_template         = "voltstack-2nic"
      vm_linked_clone = "false"
      # leave unset for dhcp
      vm_ip                     = ""
      vm_dns_0                  = ""
      vm_dns_1                  = ""
      default_route_destination = ""
      # set for static
      #vm_ip               = "192.168.1.188/24"
      #vm_dns_0            = "192.168.3.1"
      #vm_dns_1            = "192.168.2.251"
      #default_route_destination = "0.0.0.0/0"
      #default_public_gateway    = "192.168.1.254"
    },
    voltstack-2 = {
      vm_domain       = "my-domain.com"
      vsphere_cluster = "my-cluster"
      vm_datastore    = "my-datastore1"
      vm_cpu          = "4"
      vm_ram          = "16384"
      vm_disk0_size   = "40"
      vm_networks = {
        eth0 = "192.168.1.0"
        eth1 = "192.168.3.0"
      }
      vm_template = "voltstack-1nic"
      #vm_template         = "voltstack-2nic"
      vm_linked_clone = "false"
      # leave unset for dhcp
      vm_ip                     = ""
      vm_dns_0                  = ""
      vm_dns_1                  = ""
      default_route_destination = ""
      # set for static
      #vm_ip               = "192.168.1.189/24"
      #vm_dns_0            = "192.168.3.1"
      #vm_dns_1            = "192.168.2.251"
      #default_route_destination = "0.0.0.0/0"
      #default_public_gateway    = "192.168.1.254"
    }
  }
}
