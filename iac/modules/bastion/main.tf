resource "aws_instance" "bastion" {
  ami                         = "${var.ami_id}"
  key_name                    = "${var.bastion_key_pair_name}"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.bastion-sg.id}"]
  subnet_id                   = "${var.vpc_subnet_id}"
  tags = merge(
    {
      "Name" = format("%s-bastion", var.name)
    },
    var.tags)
}

resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = "${var.allowed_cidr_block}"
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
  {
    "Name" = format("%s-bastion-sg", var.name)
  },
  var.tags)
}

resource "aws_eip" "eip" {
  instance = "${aws_instance.bastion.id}"
  vpc      = true
}

output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "bastion_sg_id" {
  value = "${aws_security_group.bastion-sg.id}"
}