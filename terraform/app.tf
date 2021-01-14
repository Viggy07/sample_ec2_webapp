resource "aws_key_pair" "ssh_key_pair" {
  key_name   = var.app_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2NQAnMaAnVKZ7huSssEWLki8Bv4Y3f2IurxqI3YFU0rgJ6oNwITW5qotE8mhhCn+5xh3PDKBz2Y4XAaS1Awu6PUpb090RcPQ4SF06sylfaqdRnBGk65wMk4t4kMxQBHdaE6QICMAGRD2gIJ9EPzb1NrU3irxHF7LjwAYoCMeBWrZyTdDETaaluglX9r5Dzjg8l7NAW12LX+vAi7sH4HnXBSVktiadfcLdasA4dlMOAhTHnzvPymWRGAR0krGL9RLusqD6lSLLFW5YZXXQjw3kUk8HTD0zmJrihjkrfRU5wEBnKmGCn9/w1I7giH2JOKkk0FI+ML8Mvn+3XbQq8Jmq/j1+JZq1HWxZxMCLh/FHkb4xQdsbgLTDKqUCjU0p7thbn/Fw08ikEXBy2SZ+bnNFoKVDuTyKXmUIXlp6xcTO6t5eUHDb/7xdZMXViwnHE1T0dlfVt2C4Wo1tCjLam6vJWrxrFRdUwsJXHeqSRQv+W9Uipf8VC9j6QyRKf5PvXMJHMTvVRMlm1m01ApAQs6Kmol6U0wLIjtMwMARsIQ3zE/3L6MHcRjZUKzZqIey8AhlNicEq+pVEwmUWJLJCNH3tbLsdBVzfplQgzBO2L8lXMfWSsJb2k04DADZyOFr/3zYJmBzKwBOGjMsFr02/jRfPGmYT3DOU1g0XUBKLcMba9Q== viggy07.us@gmail.com"
}

resource "aws_security_group" "web_instance_sg" {
  name   = "${var.app_name}-security_group"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = var.source_cidr
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.source_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "web_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  disable_api_termination     = true
  key_name                    = aws_key_pair.ssh_key_pair.key_name
  associate_public_ip_address = true
  user_data                   = file("files/config.sh")
  vpc_security_group_ids      = [aws_security_group.web_instance_sg.id]
  root_block_device {
    volume_size           = 30
    delete_on_termination = true
  }
  tags = {
    env  = var.env
    Name = var.app_name
  }

}

output "sample_ec2_webapp_url" {
  value       = "http://${aws_instance.web_instance.public_ip}:3001"
  description = "The URL to connect to:"
}
