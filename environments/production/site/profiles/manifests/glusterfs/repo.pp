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
class profiles::glusterfs::repo ($version) {

  apt::ppa { "ppa:gluster/glusterfs-${version}": }

  Class['apt::ppa'] -> Package <| provider == 'apt' |>
  Class['apt::update'] -> Package <| provider == 'apt' |>

  package { 'glusterfs-client':
    ensure    => installed,
    name      => "glusterfs-client=${version}.*",
    require   => Apt::Ppa["ppa:gluster/glusterfs-${version}"],
  }->

  package { 'glusterfs-server':
    ensure    => installed,
    name      => "glusterfs-server=${version}.*",
    require   => Apt::Ppa["ppa:gluster/glusterfs-${version}"],
  }->

  service { 'glusterfs-server':
    ensure    => running,
    enable    => true,
    require   => Package['glusterfs-server'],
  }
}
