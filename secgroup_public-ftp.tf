resource "openstack_networking_secgroup_v2" "public-ftp" {
  name                 = "public-ftp"
  description          = "[tf] Allow FTP connections from anywhere"
  delete_default_rules = "true"
}

resource "openstack_networking_secgroup_rule_v2" "6a8b62c8-dd88-4252-b2cf-47c61992f559" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = "20"
  port_range_max    = "20"
  security_group_id = "${openstack_networking_secgroup_v2.public-ftp.id}"
}

resource "openstack_networking_secgroup_rule_v2" "aced33fb-667f-479b-9da2-d57f90916aae" {
  direction         = "egress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = "20"
  port_range_max    = "20"
  security_group_id = "${openstack_networking_secgroup_v2.public-ftp.id}"
}


resource "openstack_networking_secgroup_rule_v2" "819746cb-c9af-4850-89fa-e16bd7758bae" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = "20"
  port_range_max    = "21"
  security_group_id = "${openstack_networking_secgroup_v2.public-ftp.id}"
}

resource "openstack_networking_secgroup_rule_v2" "a699f5e5-e2d1-4f16-a9db-715cc93d197b" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = "20"
  port_range_max    = "21"
  security_group_id = "${openstack_networking_secgroup_v2.public-ftp.id}"
}

resource "openstack_networking_secgroup_rule_v2" "e6416ca5-fc87-462d-936e-79bb5d993c42" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = "56000"
  port_range_max    = "60000"
  security_group_id = "${openstack_networking_secgroup_v2.public-ftp.id}"
}

resource "openstack_networking_secgroup_rule_v2" "35023d8c-e7a5-4000-88bd-0ab62024cf2e" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = "56000"
  port_range_max    = "60000"
  security_group_id = "${openstack_networking_secgroup_v2.public-ftp.id}"
}
