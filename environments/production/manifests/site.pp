
class{'rsyslog::client':
  remote_servers => [
    {
      host => '10.192.76.79',
      port      => '514',
      protocol  => 'udp',
    }
  ]
}
