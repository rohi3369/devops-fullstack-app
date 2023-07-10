data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
    filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "myapache" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = "money"
  vpc_security_group_ids = [ aws_security_group.mysecuritygroup.id ]
  subnet_id      = aws_subnet.publicsubnets[0].id
  associate_public_ip_address = true
  
  tags = {
    Name = "myapache"
  }
}

resource "null_resource" "dev_provisioner" {
  triggers = {
    public_ip = aws_instance.myapache.public_ip
  }
  connection {
    type = "ssh"
    host  = aws_instance.myapache.public_ip
    user  = "ubuntu"
    private_key = file("C:/Users/Dell/.ssh/id_rsa")
  }
provisioner "remote-exec" {
    inline = [
    "sudo apt update" ,
    "sudo apt install apache2 -y",
   "echo '<h1> adminpage <h1>' > index.html",
    "sudo mkdir /var/www/html/admin",
    "sudo cp index.html  /var/www/html/admin/index.html",
    "sudo apt update" ,
   "echo '<h1> orderspage <h1>' > index.html",
    "sudo mkdir /var/www/html/orders",
    "sudo cp index.html  /var/www/html/orders/index.html"
    ]
  }
}