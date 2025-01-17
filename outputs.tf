output "lb_dns_name" {
    value = aws_lb.test.name
}

output "lb_arn" {
    value = aws_lb.test.arn
}

output "tg_arn" {
    value = aws_lb_target_group.test.arn
}

output "instance1_id" {
    value = aws_instance.main1.id
} 

output "instance2_id" {
    value = aws_instance.main2.id  
}

output "instance1_ip" {
    value = aws_instance.main1.private_ip
}

output "instance2_ip" {
    value = aws_instance.main2.private_ip
}

output "instance1_public_ip" {
    value = aws_instance.main1.public_ip
}

output "instance2_public_ip" {
    value = aws_instance.main2.public_ip
}

output "instance1_az" {
    value = aws_instance.main1.availability_zone
}

output "instance2_az" {
    value = aws_instance.main2.availability_zone
}

output "instance1_subnet_id" {
    value = aws_instance.main1.subnet_id
}

output "instance2_subnet_id" {
    value = aws_instance.main2.subnet_id
}

output "instance1_security_group_id" {
    value = aws_instance.main1.security_groups
}

output "instance2_security_group_id" {
    value = aws_instance.main2.security_groups
}

