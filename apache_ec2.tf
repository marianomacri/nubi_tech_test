data "template_file" "apache_user_data" {
  template = "${file("./userdata/apache_userdata.json.tpl")}"
}

resource "aws_instance" "apache_webserver" {
  ami                     = data.aws_ami.amazonlinux2.id
  instance_type           = lookup(var.apache_details, "instance_type")
  subnet_id               = var.private_subnet_id
  iam_instance_profile    = aws_iam_instance_profile.webserver_instance_profile.name
  monitoring              = "true"
  disable_api_termination = "true"
  user_data               = data.template_file.apache_user_data.rendered
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]

  root_block_device {
    volume_size           = lookup(var.apache_details, "instance_volume_size")
    volume_type           = "gp2"
    encrypted             = "true"
    delete_on_termination = "false"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [ami, id]
  }

  tags = {
    Name = lookup(var.apache_details, "name")
  }

}