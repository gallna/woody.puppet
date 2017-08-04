# Class: profiles::glusterfs::repo
#
# Manage client-side GlusterFS mounts.
#
# Sample Usage :
#  class { 'profiles::glusterfs::client':
#     host => "ip-10-192-64-221",
#     volume => "YogiBerra"
#  }
#
class profiles::glusterfs::repo ($version = '3.7') {

  apt::ppa { "ppa:gluster/glusterfs-${version}":
    before => Exec['apt-update']
  }

  Class['apt::ppa'] -> Package <| provider == 'apt' |>
  Class['apt::update'] -> Package <| provider == 'apt' |>

  package { 'glusterfs-client':
    ensure    => installed,
    name      => "glusterfs-client=${version}.*",
    require   => Class['apt::ppa'],
  }->

  package { 'glusterfs-server':
    ensure    => installed,
    name      => "glusterfs-server=${version}.*",
    require   => Class['apt::ppa'],
  }->

  service { 'glusterfs-server':
    ensure    => running,
    enable    => true,
    require   => Package['glusterfs-server'],
  }
}
