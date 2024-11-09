variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  default = "10.0.0.0/24"
}

variable "public_subnet_2_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_1_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet_2_cidr" {
  default = "10.0.3.0/24"
}

variable "public_subnet_1_availability_zone" {
  default = "ca-central-1a"
}

variable "public_subnet_2_availability_zone" {
  default = "ca-central-1b"
}

variable "private_subnet_1_availability_zone" {
  default = "ca-central-1a"
}

variable "private_subnet_2_availability_zone" {
  default = "ca-central-1b"
}

variable "eks_version" {
  default = "1.29"
}
variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "eks_cluster"
}

variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  default     = ["t3.medium"]
}

variable "key_name" {
  default = "wsl-ubuntu"
}

variable "desired_size" {
  default = "2"
}

variable "max_size" {
  default = "12"
}

variable "min_size" {
  default = "2"
}
