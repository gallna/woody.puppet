# an example profile for mco clients
class mco::client inherits mco::middleware {

  $plugins = hiera('mcollective::plugin')
  create_resources('mcollective::plugin', $plugins)
  
}
