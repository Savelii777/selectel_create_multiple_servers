# Terraform initialization and provider configuration
# You can find a description of all the parameters above under Provider Configuration
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.53.0"
    }
    selectel = {
      source = "selectel/selectel"
      version = "4.0.1"
    }
  }
}
provider "openstack" {
  auth_url    = "https://api.selvpc.ru/identity/v3"
  domain_name = "287099"
  tenant_id = "9a9f4b6c2dcc44bb8a490b7598225fe0"
  user_name   = "Savelii"
  password    = "555666777Savva"
  region      = var.region
}
provider "selectel" {
  domain_name = "287099"
  username    = "Savelii"
  password    = "555666777Savva"
}

# Creating the SSH key
resource "openstack_compute_keypair_v2" "key_tf" {
  name       = "key_tf"
  region     = var.region
  public_key = var.public_key
}

# Request external-network ID by name
data "openstack_networking_network_v2" "external_net" {
  name = "external-network"
}

# Creating a router
resource "openstack_networking_router_v2" "router_tf" {
  name                = "router_tf"
  external_network_id = data.openstack_networking_network_v2.external_net.id
}

# Creating a network
resource "openstack_networking_network_v2" "network_tf" {
  name = "network_tf"
}

# Creating a subnet
resource "openstack_networking_subnet_v2" "subnet_tf" {
  network_id = openstack_networking_network_v2.network_tf.id
  name       = "subnet_tf"
  cidr       = var.subnet_cidr
}

# Connecting the router to the subnet
resource "openstack_networking_router_interface_v2" "router_interface_tf" {
  router_id = openstack_networking_router_v2.router_tf.id
  subnet_id = openstack_networking_subnet_v2.subnet_tf.id
}

# Searching for the image ID (that the server will be created from) by its name
data "openstack_images_image_v2" "ubuntu_image" {
  most_recent = true
  visibility  = "public"
  name        = "Ubuntu 20.04 LTS 64-bit"
}

# Creating a unique flavor name
resource "random_string" "random_name_server" {
  length  = 16
  special = false
}

# Creating a server configuration with 1 vCPU and 1 GB RAM
# Parameter  disk = 0  makes the network volume a boot one
resource "openstack_compute_flavor_v2" "flavor_server" {
  name      = "server-${random_string.random_name_server.result}"
  ram       = "4096"
  vcpus     = "4"
  disk      = "5"
  is_public = "false"
}

# Creating a 5 GB network boot volume from the image
resource "openstack_blockstorage_volume_v3" "volume_server" {
  name                 = "volume-for-server1"
  size                 = "5"
  image_id             = data.openstack_images_image_v2.ubuntu_image.id
  volume_type          = var.volume_type
  availability_zone    = var.az_zone
  enable_online_resize = true
  lifecycle {
    ignore_changes = [image_id]
  }
}
resource "random_string" "random_name" {
  length  = 5
  special = false
}

resource "random_string" "random_server_name" {
  count   = var.replicas_count
  length  = 5
  special = false
}


resource "openstack_networking_port_v2" "port" {
  count      = var.replicas_count
  name       = "${var.server_name}-${random_string.random_server_name[count.index].result}-eth0"
  network_id = openstack_networking_network_v2.network_tf.id

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet_tf.id
  }
}

resource "openstack_compute_instance_v2" "instance" {
  count             = var.replicas_count
  name              = "${var.server_name}-${random_string.random_server_name[count.index].result}"
  image_id          = data.openstack_images_image_v2.ubuntu_image.id
  flavor_id         = openstack_compute_flavor_v2.flavor_server.id
  key_pair          = openstack_compute_keypair_v2.key_tf.id
  availability_zone = var.az_zone

  network {
    port = openstack_networking_port_v2.port[count.index].id
  }

  lifecycle {
    ignore_changes = [image_id]
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}