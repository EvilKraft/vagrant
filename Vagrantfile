# -*- mode: ruby -*-
# vi: set ft=ruby :

IP_ADDRESS_PRIVATE      =   "10.66.140.113"

IP_ADDRESS              =   "192.168.0.99"
DEFAULT_GETAWAY         =   "192.168.0.10"			# "10.66.140.254"

#PROVISION_SCRIPT       =   "provision.sh"
PROVISION_SCRIPT        =   "provision-php56.sh"
#PROVISION_SCRIPT       =   "provision-php56_rvm_git.sh"

# Slashes are *nix style forward slashes
PROJECT_WWW_DIR         =   "C:/web-projects/www"
PROJECT_LOG_DIR         =   "C:/web-projects/log"
PROJECT_SENDMAIL_DIR    =   "C:/web-projects/sendmail"


# Auto-select Network Adapter
# http://stackoverflow.com/a/17729961
	pref_interface = [
		'Qualcomm Atheros AR9285 802.11b/g/n WiFi Adapter', 
		'Realtek PCIe GBE Family Controller', 
		'phion Virtual Adapter (VPN)'
	]
	vm_interfaces  = %x( VBoxManage list bridgedifs | grep -E "^Name" ).gsub(/Name:\s+/, '').split("\n")
	vm_inter_stats = %x( VBoxManage list bridgedifs | grep ^Status ).gsub(/Status:\s+/, '').split("\n")

	a = Array.new()
	vm_inter_stats.each_with_index {|val, index|
		if val == "Up"
			a << vm_interfaces.at(index)
			#puts "#{val} => #{index}"
		end
	}
	vm_interfaces = a

	pref_interface = pref_interface.map {|n| n if vm_interfaces.include?(n)}.compact
	NETWORK_INTERFACE = pref_interface[0]
# End Auto-select Network Adapter


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "bento/centos-7.1"

    config.vm.box_check_update = false
	
	config.vm.network "private_network", ip: IP_ADDRESS_PRIVATE

	unless NETWORK_INTERFACE.nil? || NETWORK_INTERFACE.empty?
		config.vm.network "public_network", ip: IP_ADDRESS , :bridge => NETWORK_INTERFACE
		config.vm.provision "shell", run: "always", inline: "route add default gw " + DEFAULT_GETAWAY
	end	
	
	#config.vm.network "private_network", ip: IP_ADDRESS 
	#config.vm.provider :virtualbox do |vb|
    #  vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	#end

	config.vm.synced_folder PROJECT_WWW_DIR,      "/home/vagrant/www",      create: true, group: "vagrant", owner: "vagrant", mount_options: ["dmode=777", "fmode=777"]
	config.vm.synced_folder PROJECT_LOG_DIR,      "/home/vagrant/log",      create: true, group: "vagrant", owner: "vagrant", mount_options: ["dmode=777", "fmode=777"]
    config.vm.synced_folder PROJECT_SENDMAIL_DIR, "/home/vagrant/sendmail", create: true, group: "vagrant", owner: "vagrant", mount_options: ["dmode=777", "fmode=777"]

    config.vm.provision "shell", path: PROVISION_SCRIPT

    config.ssh.username = "vagrant"

    config.ssh.password = "vagrant"
end