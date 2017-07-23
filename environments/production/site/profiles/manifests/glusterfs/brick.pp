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

  $mount_point = "/srv/${device}/${brick}"

  file { [ "/srv/${device}", $mount_point ]:
    ensure  => directory,
    seltype => 'usr_t',
  }

  exec {"mkfs /dev/${device}":
    command     => "/sbin/mkfs.ext4 /dev/${device}",
    unless      => "/sbin/blkid -t TYPE=ext4 /dev/${device}"
  }

  mount { $mount_point:
    ensure  => "mounted",
    device  => "/dev/${device}",
    fstype  => 'ext4',
    options => 'defaults',
    atboot  => true,
    require => [ Exec["mkfs /dev/${device}"], File[$mount_point] ],
  }
}
