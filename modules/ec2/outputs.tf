output "bastion_elastic_ip" {
  description = "Bastion ip address"
  value       = aws_eip.bastion_eip.public_ip
}
