data "aws_ami" "selected" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "^amzn2-ami-hvm-2.*-x86_64-ebs"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.selected.id
  instance_type          = "t3.micro"
  key_name               = "${var.product}-${var.env}-bastion"
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [
    aws_security_group.bastion.id,
    var.security_group_id
  ]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = var.disk_size
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name        = "${title(var.product)} Bastion - ${title(var.env)}"
    Product     = var.product
    Environment = var.env
  }

}
