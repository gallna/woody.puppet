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

  file { [ '/export', "/export/${volume}" ]:
    ensure  => 'directory',
  }->

  package { 'glusterfs-client':
    ensure => installed,
    name   => 'glusterfs-client=3.7.*',
    install_options => [ '--reinstall', '--force-yes' ],
  }->

  file_line { 'bashrc_proxy':
    ensure            => absent,
    path              => '/etc/fstab',
    line              => '10.192.74.37:YogiBerra	10.192.74.37:YogiBerra	glusterfs	defaults,noauto,_netdev,use-readdirp=yes,direct-io-mode=disable	0	0',
    match             => '^10.192.74.37:YogiBerra[ ]+10.192.74.37:YogiBerra',
    match_for_absence => true,
  }->

  mount { "/export/${volume}" :
    ensure  => 'mounted',
    device  => "${host}:${volume}",
    fstype  => 'glusterfs',
    options => 'defaults,noauto,_netdev,use-readdirp=yes,direct-io-mode=disable',
    atboot  => true,
  }
}
