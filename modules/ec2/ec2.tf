resource "aws_instance" "Ubuntu_LTS" {
    ami = var.ami_id
    subnet_id = pub-subnet.id
    user_data = <<EOF
#!/bin/bash 
apt-get update
apt-get -y install nginx
sudo systemctl enable nginx
sudo systemctl start nginx  
EOF
    tags = {
        Name = "Ubuntu 20.04 LTS"
    }
  
}