resource "aws_instance" "Ubuntu_LTS" {
    ami = var.ami_id
    subnet_id = pub-subnet.id
    user_data = <<EOF
#!/bin/bash 
sudo wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
cd /etc/apt
deb http://nginx.org/packages/ubuntu focal nginx
deb-src http://nginx.org/packages/ubuntu focal nginx
apt-get update
apt-get -y install nginx
sudo systemctl enable nginx
sudo systemctl start nginx  
EOF
    tags = {
        Name = "Ubuntu 20.04 LTS"
    }
  
}