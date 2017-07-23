# Class: profiles::glusterfs::client
#
# Manage client-side GlusterFS mounts.
#
# Sample Usage :
#  class { 'profiles::glusterfs::client':
#     host => "ip-10-192-64-221",
#     volume => "YogiBerra"
#  }
#
class profiles::glusterfs::client ($host, $volume) {

  $mount_point = "/export/${volume}"

  file { $mount_point:
    ensure  => directory,
    seltype => 'usr_t',
  }

  package { 'glusterfs-fuse': ensure => installed }

  mount { $mount_point:
    ensure  => 'mounted',
    device  => "${host}:${volume}",
    fstype  => 'glusterfs',
    options => 'noatime,nodev,noexec,nosuid',
    atboot  => true,
    require => [ Package['glusterfs-fuse'], File[$mount_point] ],
  }
}
