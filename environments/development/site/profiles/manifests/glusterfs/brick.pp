# Class: profile::jenkins::master
#
# Install a Jenkins master that meets Puppet's internal needs.
#
# Sample Usage :
#  class { 'profiles::glusterfs::brick':
#     device => "xvdf",
#     brick => "MickeyMouse"
#  }
#
class profiles::glusterfs::brick ($device, $brick) {

  exec {"mkfs /dev/${device}":
    command     => "/sbin/mkfs.ext4 /dev/${device}",
    unless      => "/sbin/blkid -t TYPE=ext4 /dev/${device}"
  }->

  file { [ "/srv/${device}", "/srv/${device}/${brick}" ]:
    ensure  => directory,
  }->

  mount { "/srv/${device}/${brick}":
    ensure  => "mounted",
    device  => "/dev/${device}",
    fstype  => 'ext4',
    options => 'defaults',
    atboot  => false,
  }
}
