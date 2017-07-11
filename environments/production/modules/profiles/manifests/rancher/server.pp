# Class: profiles::rancher::server
# ===========================
# Run the Rancher Server container.
#
class profiles::rancher::server {
  class { '::rancher::server':
    image_tag => 'v1.6.1'
  }
}
