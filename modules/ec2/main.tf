data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "bastion_ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = "${var.env_name}-bastion"
  instance_type               = var.bastion_instance_type
  ami                         = data.aws_ami.amazon_linux.id
  associate_public_ip_address = true
  key_name                    = "${var.env_name}-bastion-key"
  monitoring                  = false
  vpc_security_group_ids      = var.bastion_sgs
  subnet_id                   = var.bastion_subnet_id
  tags                        = var.common_tags
}


resource "aws_eip" "bastion_eip" {
  instance = module.bastion_ec2_instance.id
  domain   = "vpc"
  tags = merge(var.common_tags, {
    Name = "${var.env_name}-bastion-eip"
  })
}
