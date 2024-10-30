# MongoDB Variables
variable "mongo_ami" {
  type    = string
  default = "ami-06aa3f7caf3a30282"
}

variable "mongo_sg" {
  type    = list(string)
  default = ["sg-0803c2dc1f4f57be5"]
}

variable "mongo_subnet" {
  type    = string
  default = "subnet-08a6e08f17656a455"
}

variable "mongo_priv_ip" {
  type    = string
  default = "10.0.0.16"
}

# App Variables

variable "key_name" {
  type    = string
  default = "hvega"
}

variable "app_ami" {
  type    = string
  default = "ami-06aa3f7caf3a30282"
}

variable "app_sg" {
  type    = list(string)
  default = ["sg-079a94b1dd73df7c6"]
}

variable "app_subnet" {
  type    = string
  default = "subnet-08a6e08f17656a455"
}

variable "app_priv_ip" {
  type    = string
  default = "10.0.0.17"
}