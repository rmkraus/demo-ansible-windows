# app server
resource "aws_instance" "rhel" {
  count                     = "${var.rhel_node_count}"
  ami                       = "${var.ami_id_rhel}"
  instance_type             = "${var.app_instance_type}"
  subnet_id                 = "${aws_subnet.main.id}"
  vpc_security_group_ids    = ["${aws_security_group.main.id}"]
  key_name                  = "${aws_key_pair.main.id}"
  availability_zone         = "${var.aws_availability_zone}"
  depends_on                = ["aws_subnet.main"]

  tags = {
    Name                    = "${var.demo_prefix}_rhel_${count.index}"
  }
}
resource "aws_eip" "rhel" {
  count                     = "${var.rhel_node_count}"
  instance                  = "${element(aws_instance.rhel.*.id, count.index)}"
  vpc                       = true
  depends_on                = ["aws_instance.rhel"]

  tags = {
    Name                    = "${var.demo_prefix}_rhel_eip_${count.index}"
  }
}
resource "aws_route53_record" "rhel" {
  count                     = "${var.rhel_node_count}"
  zone_id                   = "${var.aws_r53_zone_id}"
  name                      = "rhel-${count.index}.${var.demo_prefix}"
  type                      = "A"
  ttl                       = "300"
  records                   = ["${element(aws_eip.rhel.*.public_ip, count.index)}"]
}
