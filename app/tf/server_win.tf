# app server
resource "aws_instance" "win" {
  count                     = "${var.win_node_count}"
  ami                       = "${var.ami_id_win}"
  instance_type             = "${var.app_instance_type}"
  subnet_id                 = "${aws_subnet.main.id}"
  vpc_security_group_ids    = ["${aws_security_group.main.id}"]
  key_name                  = "${var.win_pass_key}"
  availability_zone         = "${var.aws_availability_zone}"
  depends_on                = ["aws_subnet.main"]

  tags = {
    Name                    = "${var.demo_prefix}_win_${count.index}"
  }
}
resource "aws_eip" "win" {
  count                     = "${var.win_node_count}"
  instance                  = "${element(aws_instance.win.*.id, count.index)}"
  vpc                       = true
  depends_on                = ["aws_instance.win"]

  tags = {
    Name                    = "${var.demo_prefix}_win_eip_${count.index}"
  }
}
resource "aws_route53_record" "win" {
  count                     = "${var.win_node_count}"
  zone_id                   = "${var.aws_r53_zone_id}"
  name                      = "win-${count.index}.${var.demo_prefix}"
  type                      = "A"
  ttl                       = "300"
  records                   = ["${element(aws_eip.win.*.public_ip, count.index)}"]
}
