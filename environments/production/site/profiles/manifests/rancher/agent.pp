# Class: profiles::rancher::agent
# ===========================
# Run Rancher agent container.
#
class profiles::rancher::agent($server_url) {
  class { 'docker':
    version => '1.12.3-0~trusty'
  }

  class { '::rancher':
    registration_url => $server_url,
  }
}
