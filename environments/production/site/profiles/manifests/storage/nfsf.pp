# Class: profiles::storage::nfsf
#
# Ensure storage mounted
#
class profiles::storage::nfsf (
  $mountpoint = '/srv/xvdf',
  $device = '/dev/xvdf',
  $fstype = 'ext4'
  ) {
  file { $mountpoint :
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0777',
    recurse => true,
    path    => $mountpoint,
  } -> mount { $mountpoint :
    ensure  => 'mounted',
    fstype  => $fstype,
    device  => $device,
    name    => $mountpoint,
    options => "rw,noexec,nosuid,nodev,noatime,nodiratime,acl,_netdev",
    atboot  => true,
  }
}
