$content = @("EOF")

-------------------------------------------------
<%= @operatingsystem %>; <%= @operatingsystemrelease %>; <%= @architecture -%>
; <%= @kernel %> <%= @kernelversion %>;
Tags:      role : <%= Facter.value(:role) %>
          group : <%= Facter.value(:group) %>
      hostgroup : <%= Facter.value(:hostgroup) %>
    environment : <%= @environment %>
-------------------------------------------------
Puppet: <%= @puppetversion %>; Facter: <%= @facterversion -%>
; Ruby: <%= @rubyversion %>
FQDN:       <%= @fqdn %>
Host:       <%= @hostname %> (<%= @ipaddress %>)
Processor:  <%= @processor0 %>, <%= @memorysize %> RAM
-------------------------------------------------
EOF
notice(inline_template($content))

# applies to nodes that aren't explicitly defined
node default {

  file_line { 'bashrc_proxy':
    ensure            => absent,
    path              => '/tmp/fstab',
    line              => 'export HTTP_PROXY=http://squid.puppetlabs.vm:3128',
    match             => '^10.192.74.37:/YogiBerra\s+/export/YogiBerra',
    match_for_absence => true,
  }

}
