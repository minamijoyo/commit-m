# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "opscode-centos-6.5"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"

  config.vm.network :"forwarded_port", guest: 3000, host: 3000
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|

    chef.cookbooks_path = "./cookbooks"
    chef.run_list = [
    ]
    chef.add_recipe 'build-essential'
    chef.add_recipe 'git'
    chef.add_recipe 'rvm::system'
    chef.add_recipe 'sqlite'

    chef.json = {
      rvm: {
        user: "root",
        default_ruby: "ruby-2.2",
        user_default_ruby: "ruby-2.2",
        rubies: ["ruby-2.2" ]
      }
    }
  end
end
