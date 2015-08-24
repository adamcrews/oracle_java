require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts

# Set the puppetversion fact
RSpec.configure do |c|
  c.default_facts = {
    :puppetversion => Puppet.version
  }
end
