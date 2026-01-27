resource "aws_lightsail_static_ip" "web" {
  name = "${var.app_name}_staticip"
}

resource "aws_lightsail_key_pair" "web" {
  name       = "${var.app_name}_key"
  public_key = file("~/.ssh/${var.app_name}.pub")

  lifecycle {
    ignore_changes = [
      public_key
    ]
  }
}

resource "aws_lightsail_instance" "web" {
  name              = "${var.app_name}_instance"
  ip_address_type   = "ipv4"
  availability_zone = "${var.region}c"
  blueprint_id      = "ubuntu_24_04"
  bundle_id         = "medium_2_0"
  key_pair_name     = "${var.app_name}_key"
}

resource "aws_lightsail_static_ip_attachment" "web" {
  static_ip_name = aws_lightsail_static_ip.web.name
  instance_name  = aws_lightsail_instance.web.name
}

resource "aws_lightsail_instance_public_ports" "web" {
  instance_name = aws_lightsail_instance.web.name

  port_info {
    protocol          = "tcp"
    from_port         = 22
    to_port           = 22
    cidrs             = ["${var.allow_ssh_ip}/32"]
    cidr_list_aliases = ["lightsail-connect"]
  }

  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }

  port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }
}
