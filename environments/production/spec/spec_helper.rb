require 'puppetlabs_spec_helper/module_spec_helper'
require 'jimdo-rspec-puppet-helpers'
require 'rspec-puppet-facts'
RSpec.configure do |c|
 c.module_path = "modules:site"
 c.manifest_dir = 'manifests'
end
