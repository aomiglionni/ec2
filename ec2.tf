resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.subnet_pub_1b.id
  private_ips = ["172.34.3.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "web" {
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = "aprendanuvem"
  iam_instance_profile = aws_iam_instance_profile.s3_profile.name

  user_data = "${file("install_apache.sh")}"

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
  tags = {
    "Name"    = "Webserver"
    "Env"     = "Dev"
    "Owner"   = "Alberto Miglionni"
    "Criado"  = "Terraform"
    "Version" = "Gitlab"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_1.id
  instance_id = aws_instance.web.id
}

resource "aws_ebs_volume" "ebs_1" {
  availability_zone = var.az_1b
  size              = 8
}

resource "aws_eip" "eip_web" {
  instance = aws_instance.web.id
  vpc      = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.eip_web.id
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.allow_web.id
  network_interface_id = aws_network_interface.foo.id
}