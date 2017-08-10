# Class: profiles::puppet::agent
# ===========================
# Configure puppet agent.
#
class profiles::puppet::agent (
  $collective = 'mcollective'
  ) {

  class { '::puppet::profile::agent':
    allinone      => true,
    collection    => 'PC1',
    show_diff     => true,
    reports       => true,
    puppet_server => $::puppet_server,
    custom_facts => {
      'collective'  => $collective,
    }
  }
}
