# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

Vagrant.configure(2) do |config|

  # pinning to v1.0.1 of the box to get Puppet 3.7.x vs
  # newer boxes that use 4.x
  config.vm.box = "puppetlabs/centos-6.6-64-puppet"
  config.vm.box_version = '1.0.1'

  config.vm.provider :virtualbox do |vb|
    vb.customize [ "modifyvm", :id, "--cpus", "4"]
    vb.customize [ "modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.provider :vmware_fusion do |vf|
    vf.vmx["numvcpus"] = "4"
  end

  config.vm.define 'java' do |java|
    java.vm.hostname = 'java.my.vm'

    metadata = JSON.parse(File.read('metadata.json'))
    metadata['dependencies'].each do |m|
      java.vm.provision :shell, inline: "puppet module install #{m['name']} --modulepath=/vagrant/tests/modules"
    end

    java.vm.provision :shell, inline: '[ -L /vagrant/tests/modules/oracle_java ] || (mkdir -p /vagrant/tests/modules ; ln -s /vagrant /vagrant/tests/modules/oracle_java)'

  # stash.vm.provision :shell, inline: "sudo yum install -y epel-release"

    java.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file  = "init.pp"
      puppet.module_path = "tests/modules"
    end

  end

end
