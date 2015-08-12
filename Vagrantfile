# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "puppetlabs/centos-6.6-64-puppet"

  config.vm.provider :virtualbox do |vb|
    vb.customize [ "modifyvm", :id, "--cpus", "4"]
    vb.customize [ "modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.provider :vmware_fusion do |vf|
    vf.vmx["numvcpus"] = "4"
  end

  config.r10k.puppet_dir = "tests"
  config.r10k.puppetfile_path = "Puppetfile"
  config.r10k.module_path = "tests/modules"

  config.vm.define 'java' do |java|
    java.vm.hostname = 'java.my.vm'

    java.vm.provision :shell, inline: '[ -f /vagrant/tests/modules/oracle_java ] || mkdir -p /vagrant/tests/modules ; ln -s /vagrant /vagrant/tests/modules/oracle_java'

  # stash.vm.provision :shell, inline: "sudo yum install -y epel-release"

    java.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file  = "init.pp"
      puppet.module_path = "tests/modules"
    end

  end

end
