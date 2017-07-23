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
class profiles::glusterfs::repo ($version = '3.8') {

  class { 'apt': }

  apt::ppa { "ppa:gluster/glusterfs-${version}": }
}
