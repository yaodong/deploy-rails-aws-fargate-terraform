output "ami" {
  value = data.aws_ami.selected.name
}

output "public_ip" {
  value = aws_instance.bastion.public_ip
}
