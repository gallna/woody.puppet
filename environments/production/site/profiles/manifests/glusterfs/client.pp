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

  file { '/export':
    ensure  => directory,
    seltype => 'usr_t',
  }

  file { $mount_point:
    ensure  => directory,
    seltype => 'usr_t',
  }

  package { 'glusterfs-client': ensure => installed }

  mount { $mount_point:
    ensure  => 'mounted',
    device  => "${host}:${volume}",
    fstype  => 'glusterfs',
    options => 'noatime,nodev,noexec,nosuid',
    atboot  => true,
    require => [ Package['glusterfs-client'],
                 File['/export'],
                 File[$mount_point] ],
  }
}
