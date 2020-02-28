output "ip" {
  value = aws_eip.eip_web.public_ip
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.web.private_ip
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = aws_instance.web.security_groups
}

output "instance_state" {
  description = "List of instance states of instances"
  value       = aws_instance.web.instance_state
}

