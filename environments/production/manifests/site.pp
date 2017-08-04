# applies to nodes that aren't explicitly defined
node default {}

$hiera_classes = lookup('classes', {merge => unique})
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
Classes:
<% @hiera_classes.each do |hiera_class| -%>
          + <%= hiera_class %>
<% end -%>
-------------------------------------------------
EOF
notice(inline_template($content))

$hiera_classes.include
