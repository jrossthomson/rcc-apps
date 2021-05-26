#
# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "cloudsql" {
  description = "Define an existing CloudSQL instance to use instead of instance-local MySQL"
  type = object({
    server_ip = string,
    user      = string,
    password  = string,
    db_name   = string})
  default = null
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "compute_image_disk_size_gb" {
  description = "Size of disk for compute node image."
  default     = 50
}

variable "compute_image_disk_type" {
  description = "Disk type (pd-ssd or pd-standard) for compute node image."
  type        = string
  default     = "pd-standard"
}

variable "compute_image_labels" {
  description = "Labels to add to the compute node image. List of key key, value pairs."
  type        = any
  default     = {}
}

variable "compute_image_machine_type" {
  type    = string
  default = "n1-standard-2"
}

variable "compute_node_scopes" {
  description = "Scopes to apply to compute nodes."
  type        = list(string)
  default     = [
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/logging.write"
  ]
}

variable "compute_node_service_account" {
  description = "Service Account for compute nodes."
  type        = string
  default     = "default"
}

variable "controller_machine_type" {
  description = "Machine type to use for the controller instance"
  type        = string
  default     = "n1-standard-2"
}

variable "controller_disk_type" {
  description = "Disk type (pd-ssd or pd-standard) for controller."
  type        = string
  default     = "pd-standard"
}

variable "controller_disk_size_gb" {
  description = "Size of disk for the controller."
  type        = number
  default     = 50
}

variable "controller_image" {
  description = "Disk OS image (with Slurm) path for controller instance"
  type = string
  default = "projects/hpc-apps/global/images/wrf-gcp-v1"
}

variable "login_image" {
  description = "Disk OS image (with Slurm) path for login instance"
  type = string
  default = "projects/hpc-apps/global/images/wrf-gcp-v1"
}

variable "controller_labels" {
  description = "Labels to add to controller instance. List of key key, value pairs."
  type        = any
  default     = {}
}

variable "controller_secondary_disk" {
  description = "Create secondary disk mounted to controller node"
  type        = bool
  default     = false
}

variable "controller_secondary_disk_size" {
  description = "Size of disk for the secondary disk"
  default     = 100
}

variable "controller_secondary_disk_type" {
  description = "Disk type (pd-ssd or pd-standard) for secondary disk"
  default     = "pd-ssd"
}

variable "controller_scopes" {
  description = "Scopes to apply to the controller"
  type        = list(string)
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "controller_service_account" {
  description = "Service Account for the controller"
  type        = string
  default     = "default"
}

variable "disable_login_public_ips" {
  type    = bool
  default = true
}

variable "disable_controller_public_ips" {
  type    = bool
  default = true
}

variable "disable_compute_public_ips" {
  type    = bool
  default = true
}

variable "login_disk_type" {
  description = "Disk type (pd-ssd or pd-standard) for login nodes."
  type        = string
  default     = "pd-standard"
}

variable "login_disk_size_gb" {
  description = "Size of disk for login nodes."
  type        = number
  default     = 50
}

variable "login_labels" {
  description = "Labels to add to login instances. List of key key, value pairs."
  type        = any
  default     = {}
}

variable "login_machine_type" {
  description = "Machine type to use for login node instances."
  type        = string
  default     = "n1-standard-2"
}

variable "login_network_storage" {
  description = "An array of network attached storage mounts to be configured on the login and controller instances."
  type = list(object({
    server_ip     = string,
    remote_mount  = string,
    local_mount   = string,
    fs_type       = string,
    mount_options = string}))
  default = []
}

variable "login_node_scopes" {
  description = "Scopes to apply to login nodes."
  type        = list(string)
  default     = [
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/logging.write"
  ]
}

variable "login_node_service_account" {
  description = "Service Account for compute nodes."
  type        = string
  default     = "default"
}

variable "login_node_count" {
  description = "Number of login nodes in the cluster"
  default     = 1
}

variable "munge_key" {
  description = "Specific munge key to use"
  default     = null
}

variable "network_name" {
  default = null
  type    = string
}

variable "network_storage" {
  description = " An array of network attached storage mounts to be configured on all instances."
  type = list(object({
    server_ip     = string,
    remote_mount  = string,
    local_mount   = string,
    fs_type       = string,
    mount_options = string}))
  default = []
}

variable "ompi_version" {
  description = "Version/branch of OpenMPI to install with Slurm/PMI support. Allows mpi programs to be run with srun."
  default     = null
}

variable "partitions" {
  description = "An array of configurations for specifying multiple machine types residing in their own Slurm partitions."
  type = list(object({
    name                 = string,
    machine_type         = string,
    max_node_count       = number,
    zone                 = string,
    image                = string,
    image_hyperthreads   = bool,
    compute_disk_type    = string,
    compute_disk_size_gb = number,
    compute_labels       = any,
    cpu_platform         = string,
    gpu_type             = string,
    gpu_count            = number,
    network_storage = list(object({
      server_ip    = string,
      remote_mount = string,
      local_mount  = string,
      fs_type      = string,
    mount_options = string })),
    preemptible_bursting = bool,
    vpc_subnet           = string,
    exclusive            = bool,
    enable_placement     = bool,
    regional_capacity    = bool,
    regional_policy      = any,
    instance_template    = string,
  static_node_count = number }))
}

variable "project" {
  type = string
}

variable "shared_vpc_host_project" {
  type    = string
  default = null
}

variable "slurm_version" {
  default = "19.05-latest"
}

variable "subnetwork_name" {
  description = "The name of the pre-defined VPC subnet you want the nodes to attach to based on Region."
  default     = null
  type        = string
}

variable "suspend_time" {
  description = "Idle time (in sec) to wait before nodes go away"
  default     = 300
}

variable "zone" {
  type = string
}

output "controller_network_ips" {
  value = module.slurm_cluster_controller.instance_network_ips
}

output "login_network_ips" {
  value = module.slurm_cluster_login.instance_network_ips
}
