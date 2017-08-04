# Class: profiles::global
# ===========================
# Global profile, applies to all nodes.
#
class profiles::global {
  include ntp

  package { 'attr':
    ensure => installed,
  }

  package { 'vim':
    ensure => installed,
  }

  package { 'apt-add-repository':
    ensure => installed,
    name   => 'software-properties-common',
  }
  
  class{'rsyslog::client':
    remote_servers => [
      {
        host => 'graylog.udp.wrrr.online',
        port      => '10517',
        protocol  => 'udp',
      }
    ]
  }
}
