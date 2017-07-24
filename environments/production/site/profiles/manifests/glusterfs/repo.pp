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
class profiles::glusterfs::repo ($version = '3.7') {

  tidy { '/etc/apt/sources.list.d':
    path    => '/etc/apt/sources.list.d',
    recurse => 1,
    age     => '1w',
    matches => [ 'gluster-glusterfs-3_11-trusty.*',
                 'gluster-glusterfs-3_8-trusty.*' ],
  } ->

  class { 'apt': } ->
  apt::ppa { "ppa:gluster/glusterfs-3.8": ensure => absent } ->
  apt::ppa { "ppa:gluster/glusterfs-3.11": ensure => absent } ->
  apt::ppa { "ppa:gluster/glusterfs-${version}": }

  Class['apt::ppa'] -> Package <| provider == 'apt' |>
  Class['apt::update'] -> Package <| provider == 'apt' |>
}
