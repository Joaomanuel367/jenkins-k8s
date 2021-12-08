Vagrant.configure("2") do |config|

  config.vm.network "private_network", ip: "192.168.50.20"
  config.vm.hostname = "cluster"
  config.vm.box = "centos/7"
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 4
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  end

   config.vm.provision "shell", inline: <<-SHELL
     sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
     sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config && systemctl restart sshd
   SHELL
end