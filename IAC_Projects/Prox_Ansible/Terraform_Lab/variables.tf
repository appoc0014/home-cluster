variable "ssh_key" {
  description = "SSH public key from your VM"
  type = string
  default = default     = "############################" # Removed sensitive info
}
variable "proxmox_host" {
  description = "Name of Proxmox host"
  type = string
  default = "DellHost"
}
variable "template_name" {
  type = string
  default = "Ubuntu-2024-init"
}

variable "ubuntu_img" {
  description = "Point to Ubuntu ISO on Promox storage"
  type = string
  default = "local:iso/ubuntu-24.04.3-live-server-amd64.iso"
}

variable "CentOS_img" {
  description = "Point to ISO on Promox storage"
  type = string
  default = "local:iso/CentOS.iso"
}

# Var to use secret file 
variable "PM_API_TOKEN_ID" {
  description = "The username for the DB master user"
  type        = string
  default     = "############################" # Removed sensitive info
  sensitive   = true
}

variable "PM_API_TOKEN_SECRET" {
  description = "The password for the DB master user"
  type        = string
  default     = "#############################" # Removed sensitive info
  sensitive   = true
}

variable "SSH_KEY" {
  description = "The password for the DB master user"
  type        = string
  default     = default     = "############################" # Removed sensitive info
  sensitive   = true
}
