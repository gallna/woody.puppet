# Class: profiles::etcd
#
# Ensure etcd backup storage mounted
#
class profiles::etcd () {
  file { ['/var/etcd', '/var/etcd/backups']:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0777',
  } -> class { '::nfs':
    client_enabled => true,
    nfs_v4_client  => true,
  } -> nfs::client::mount { '/var/etcd/backups':
    server        => 'fs-5e1bed97.efs.eu-west-1.amazonaws.com',
    share         => '/api/schedule-volume-io/vendor/nikic/fast-route/route/efs-schedule/etcd',
    options_nfsv4 => 'nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev',
    nfs_v4        => true,
  }
}
