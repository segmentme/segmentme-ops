# This is based on the LT that EKS would create if no custom one is specified (aws ec2 describe-launch-template-versions --launch-template-id xxx)
# there are several more options one could set but you probably dont need to modify them
# you can take the default and add your custom AMI and/or custom tags
#
# Trivia: AWS transparently creates a copy of your LaunchTemplate and actually uses that copy then for the node group. If you DONT use a custom AMI,
# then the default user-data for bootstrapping a cluster is merged in the copy.
resource "aws_launch_template" "eks-node-template" {
  name_prefix            = "${local.global_prefix}-lt"
  description            = "Eks launch template"
  update_default_version = true
  instance_type          = var.eks_instance_type

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 8
      volume_type           = "gp2"
      delete_on_termination = true
      # encrypted             = true

      # Enable this if you want to encrypt your node root volumes with a KMS/CMK. encryption of PVCs is handled via k8s StorageClass tho
      # you also need to attach data.aws_iam_policy_document.ebs_decryption.json from the disk_encryption_policy.tf to the KMS/CMK key then !!
      # kms_key_id            = var.kms_key_arn
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups = [
    aws_security_group.eks-cluster-worker-sg.id]
  }


  tag_specifications {
    resource_type = "instance"

    tags = {
      CustomTag = "EKS example"
    }
  }

  # Supplying custom tags to EKS instances root volumes is another use-case for LaunchTemplates. (doesnt add tags to dynamically provisioned volumes via PVC tho)
  tag_specifications {
    resource_type = "volume"

    tags = {
      CustomTag = "EKS example"
    }
  }

  # Supplying custom tags to EKS instances ENI's is another use-case for LaunchTemplates
  tag_specifications {
    resource_type = "network-interface"

    tags = {
      CustomTag = "EKS example"
    }
  }

  # Tag the LT itself
  tags = {
    CustomTag = "EKS example"
  }

  lifecycle {
    create_before_destroy = true
  }
}
