# Class: profiles::rancher
# ===========================
# Run the Rancher container.
#
class profiles::rancher::rancher {

  class{'rsyslog::client':
    remote_servers => [
      {
        host => 'graylog.wrrr.online',
        port => '555',
        protocol  => 'udp',
      }
    ]
  }
}
