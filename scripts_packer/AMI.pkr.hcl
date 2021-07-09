variable "aws_access_key" {
  sensitive = true
  default = ""
}
variable "aws_secret_key" {
  sensitive = true
  default = ""
}

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ami_jd" {
  access_key    = var.aws_access_key
  secret_key    = var.aws_secret_key
  ssh_timeout     = "180s"
  ami_name      = "ami-jd"
  instance_type = "t2.micro"
  region        = "us-east-1"
  ssh_username = "jose"
  encrypt_boot = "true"
  source_ami      = "ami-09af59f76f41224de"
  skip_create_ami = false
}




  

build {
  sources = [
    "source.amazon-ebs.ami_jd"
  ]
  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }
}