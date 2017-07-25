# Class: profile::jenkins::master
#
# Install a Jenkins master that meets Puppet's internal needs.
#
class profiles::glusterfs::wrrr ($allowed, $bricks) {

  # class { '::gluster':
  #   server  => false,
  #   client  => false,
  #   repo    => false,
  #   version => '3.5.2',
  #   pool    => 'production',
  #   volumes => {
  #     'g0' => {
  #       stripe => 4,
  #       bricks  => $bricks,
  #       options => [ 'nfs.disable: true',
  #                    'nfs.export-volumes: on',
  #                    'nfs.addr-namelookup: off',
  #                    "nfs.rpc-auth-allow: ${allowed}",
  #                    "auth.allow: ${allowed}" ],
  #     }
  #   }
  # }

  # Main package and service it provides
  package { 'glusterfs-server': ensure => installed }
  service { 'glusterd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['glusterfs-server'],
  }

  # Export this host's gluster::peer resource, and then collect all others:
  @@gluster::peer { $::fqdn:
    pool => 'production',
  }
  Gluster::Peer <<| pool == 'production' |>>

  # gluster::mount { '/srv/xvdf/YogiBerra':
  #   volume          => 'ip-10-192-64-221:YogiBerra',
  #   atboot          => true,
  #   log_level       => "WARNING",
  #   direct_io_mode  => 'disable',
  #   readdirp        => 'yes',
  #   log_file        => '/var/log/gluster.lo',
  #   options         => 'noatime,nodev,noexec,nosuid',
  #   transport       => 'tcp,rdma',
  # }
}
