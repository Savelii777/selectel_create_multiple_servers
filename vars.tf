variable "region" {
  default = "ru-3"
}
# SSH key to access the cloud server
variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCt9pOh2goCIpWI0sOgNlioJEe3eaQKtvQv+zDr54twEyjfWvfy02A6Nqlg2dIPkD4j3xa2KOXkpaw9PlEwkf0YlBR0QmLmnbT+2ntM2JehxTk5zbGRYtGk5IHof/HxAUMeZq31U2jvqvuS0k4Zy82Y9PSUNB60Mfgy9S7aQyhRB/AMswkJuDdLnCXNjrQa8Ez5uuhOj//LExaD57wenhVkILrRuWc53kZAVTjv9WHri23DEKS3qTm7BiltWanZ6AFpoJA0FN8702oBD6awxfNEdhEh3cY20af10LJfJU3UWPcI7z/4GseBN5p6UoT1T2MlhckgBifhtkALexjG1tNFO5+M4It9djKLydUDs4dnXMUAtA46YV4E5ea90x9qW5h9iCLs/81GUZufp7A3NZ/m3nn3Xoq6G/7d32KZ8L9WN6kv0Y89bieIURc2k/E7/X+kruIeJxlEawafs9ubo/BpplOA/ToxcW7pwdjvs4jbnRY64JE5Yrnql5qlPHSy8bx1sM7xKff2/p4V2Wnn1PSPws/U6VH7ZiCMp/ZyOOPP/Puq8c9/jxW3s2xCUFCa6HlX0RFEU//w403Fdr79P+iCIFhg2VOaFpwd1ZVXUrurBj0SplAtqHYCSG0j5/j+n6epEYouLnt5wZN0CdiVBhSb9bvlSmWnQ2YipZDXSXAO0Q== sporyshev.savelii@gmail.com"
}
# Availability Zone
variable "az_zone" {
  default = "ru-3b"
}
# Type of the network volume that the server is created from
variable "volume_type" {
  default = "fast.ru-3b"
}
# Subnet CIDR
variable "subnet_cidr" {
  default = "10.10.0.0/24"
}
variable "replicas_count" {
  default = 10
}
variable "server_name" {
  default = "server"
}