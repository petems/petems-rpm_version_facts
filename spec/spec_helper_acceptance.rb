require 'beaker-rspec'
require 'beaker/puppet_install_helper'

unless ENV['RS_PROVISION'] == 'no'
  hosts.each do |host|
    # Install Puppet
    run_puppet_install_helper
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module
    hosts.each do |host|
      copy_module_to(host, :source => proj_root, :module_name => "rpm_version_facts")
    end
  end
end
