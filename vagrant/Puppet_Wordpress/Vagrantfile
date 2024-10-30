Vagrant.configure("2") do |config|
  config.vm.define "oel7-puppet" do |vm|
    config.vm.box = "generic/oracle7"
    config.vm.hostname = "itachi"
    #config.vm.network "public_network", bridge: "Realtek Gaming GbE Family Controller"
    config.vm.network "public_network", ip: "192.168.100.30"
    config.vbguest.auto_update = false
    config.vm.provider "virtualbox" do |vb|
      vb.cpus = "2"
      vb.memory = "4096"
    end

    #Update SO and download puppet package
    config.vm.provision :shell, path: "./scripts/vboxguest.sh"

    config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file =  "init.pp"
    end    
  end
end
