terraform {
  required_version = ">= 0.15"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

# Token information for non login info
provider "proxmox" {
  pm_api_url          = "http://192.168.1.218:8006/api2/json"
  pm_api_token_id     = var.PM_API_TOKEN_ID
  pm_api_token_secret = var.PM_API_TOKEN_SECRET
  pm_tls_insecure     = true
}

# Create 2 Ubuntu VMs  
resource "proxmox_vm_qemu" "vm-ubuntu" {
  # VM Settings
  count       = 2
  name        = "Ubuntu-${count.index + 1}"
  target_node = var.proxmox_host #pve
  iso         = var.ubuntu_img   #Ubuntu ISO
  agent       = 1
  os_type     = "ubuntu"
  sockets     = 1
  cores       = 2
  memory      = 6048

  # Disk settings for VM
  disk {
    size    = "44G"
    type    = "scsi"
    storage = "local-lvm"
    discard = "on"
  }

  # Network settings for VM
  network {
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = false
    link_down = false
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  # Assign IP address using count var to increase count for each VM created
  ipconfig0 = "ip=192.168.1.17${count.index + 1}/24,gw=192.168.1.1"
}

# Create 2 CentOS VMs  
resource "proxmox_vm_qemu" "vm-centos" {
  # VM Settings
  count       = 2
  name        = "CentOS-${count.index + 1}"
  target_node = var.proxmox_host #pve
  iso         = var.CentOS_img   # CentOS ISO
  agent       = 1
  os_type     = "centos"
  sockets     = 1
  cores       = 1
  memory      = 2048

  # Disk settings for VM
  disk {
    size    = "24G"
    type    = "scsi"
    storage = "local-lvm"
    discard = "on"
  }

  # Network settings for VM
  network {
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = false
    link_down = false
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  # Assign IP address using count var to increase count for each VM created
  ipconfig1 = "ip=192.168.1.20${count.index + 1}/24,gw=192.168.1.1"

}
