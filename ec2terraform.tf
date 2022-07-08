resource "aws_instance" "chdhilton-ec2-instance" {
    count                        = var.instance_count
    ami                         = var.ami_id
    availability_zone           = var.region_az
    instance_type               = var.instance_type
    monitoring                  = false
    key_name                    = var.keypair_name
    subnet_id                   = var.subnetid
    vpc_security_group_ids      = aws_security_group.ec2-security-group.id
    associate_public_ip_address = var.associate_public_ip_address
    source_dest_check           = true
    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size}"     
        delete_on_termination = var.delete_on_termination}"  
 }
    tags {
    Name        = format("%s-ec2-instance-%d", var.project, count.index + 1)}"
    Project     = var.project}"
  }
}
 
resource "aws_security_group" "ec2-security-group" {
    name        = var.project}-ec2-sg"
    description = "Security group for EC2 Instances"
    vpc_id              = var.vpcid}"
    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "TCP"
        cidr_blocks     = "${var.ing-cidr_blocks}"
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = "${var.egr-cidr_blocks}"
        security_groups = []
        self            = true
    }
     tags {
    Name        = "${format("%s-ec2-instance-%d", var.project, count.index + 1)}"
    Project     = "${var.project}"
  }
}
