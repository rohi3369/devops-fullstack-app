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
    "curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -",
    "sudo apt install nodejs -y",
   "wget -c https://dl.google.com/go/go1.19.linux-amd64.tar.gz -O - ",
    "sudo tar -C /usr/local -xzf go1.19.linux-amd64.tar.gz",
    "export PATH=$PATH:/usr/local/go/bin",
   "source ~/.bash_profile",
    "sudo apt search golang-go -y",
   "sudo apt install golang-go -y",
"curl -fsSL https://get.docker.com -o install-docker.sh"
"sudo sh install-docker.sh -y"
    ]
  }
}
