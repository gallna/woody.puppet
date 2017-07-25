# Class: profiles::glusterfs::server
#
# GlusterFS Server.
#
# Sample Usage :
#  class { 'profiles::glusterfs::server':
#     pool => "dash"
#  }
#
class profiles::glusterfs::server ($pool) {

  # Main package and service it provides
  package { 'glusterfs-server':
    ensure => installed,
    name   => 'glusterfs-server=3.7.*',
    install_options => [ '--reinstall', '--force-yes' ],
  }

  service { 'glusterfs-server':
    ensure    => running,
    enable    => true,
    require   => Package['glusterfs-server'],
  }

  # Export this host's gluster::peer resource, and then collect all others:
  @@gluster::peer { $::fqdn:
    pool => $pool,
  }

  Gluster::Peer <<| pool == $pool |>>
}
