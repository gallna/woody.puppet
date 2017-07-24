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

  file { [ '/exports', "/exports/${volume}" ]:
    ensure  => 'directory',
  }->

  package { 'glusterfs-client':
    ensure => installed
    name   => 'glusterfs-client=3.7.*',
    install_options => [ '--force-yes' ],
  }->

  mount { "${host}:${volume}" :
    ensure  => 'mounted',
    device  => "${host}:${volume}",
    fstype  => 'glusterfs',
    options => 'defaults,_netdev,use-readdirp=yes,direct-io-mode=disable',
    atboot  => true,
    require => [ Package['glusterfs-client'], File[ "/export/${volume}" ],
  }
}
