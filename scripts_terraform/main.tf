variable "aws_acceso" {
  sensitive = true
}

variable "aws_secreto" {
  sensitive = true
}

variable "ami_id" {
  default = ""
}

variable "dominio" {
  default = ""
}

variable "db_clave" {
  sensitive = true
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_acceso
  secret_key = var.aws_secreto

}