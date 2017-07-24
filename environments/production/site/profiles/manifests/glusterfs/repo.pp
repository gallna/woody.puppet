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
    matches => [ 'gluster-glusterfs-3_8*', 'gluster-glusterfs-3_11*' ],
  }

  class { 'apt': }

  apt::ppa { "ppa:gluster/glusterfs-${version}": }
}
