resource "openstack_compute_instance_v2" "nfs-server" {

  name            = "condor_nfs"
  image_name      = "${var.vgcn_image}"
  flavor_name     = "small"
  key_pair        = "cloud"
  security_groups = ["public"]

  network {
    name = "private_net"
  }

  block_device {
    uuid                  = "d92781a6-bbb5-4238-8fd7-c38d2cc8b68f"
    source_type           = "image"
    destination_type      = "local"
    boot_index            = 0
    delete_on_termination = true
  }

  block_device {   
    uuid                  = "${openstack_blockstorage_volume_v2.volume_nfs_data.id}"
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = -1
    delete_on_termination = true
  }

  user_data = "${data.template_cloudinit_config.nfs-share.rendered}"
}


resource "openstack_blockstorage_volume_v2" "volume_nfs_data" {
  name = "condor.volume_nfs_data"
  size = "${var.nfs_disk_size}"
}

data "template_cloudinit_config" "nfs-share" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = "${file("${path.module}/files/create_share.sh")}"
  }

  part {
    content_type = "text/cloud-config"
    content      = <<-EOF
    #cloud-config
    write_files:
    - content: |
        /data/share *(rw,sync)
      owner: root:root
      path: /etc/exports
      permissions: '0644'

    runcmd:
     - [ systemctl, enable, nfs-server ]
     - [ systemctl, start, nfs-server ]
     - [ exportfs, -avr ]
  EOF
  }


}
