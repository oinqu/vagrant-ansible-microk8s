# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

Vagrant.require_version ">= 2.2.5"
VAGRANTFILE_API_VERSION = "2"

machines = YAML.load_file('hosts.yml')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.provider 'libvirt'
    
    machines.each do |machine|
        config.vm.define machine['name'] do |node|

            node.vm.box = machine['box']
            node.vm.hostname = machine['name']
            node.vm.synced_folder '.', '/vagrant', disabled: true
            node.vm.network :private_network, :ip => machine['ip']

            node.vm.provider 'libvirt' do |vb|
                vb.memory = machine['ram']
                vb.cpus = machine['cpus']
            end

            if machine.has_key?('network_ports')
                machine['network_ports'].each do |port|
                    node.vm.network "forwarded_port", guest: port['guest'], host: port['host']
                end
            end

            if machine.has_key?('disks')
                node.vm.provider :libvirt do |libvirt|
                    machine['disks'].each do |disks|
                        libvirt.storage :file, disks['disk']['options']
                    end
                end
            end

            if machine.has_key?('nfs_folders')              
                machine['nfs_folders'].each do |nfs_folders|
                    node.vm.synced_folder nfs_folders['src'], nfs_folders['dest'], type: "nfs"
                end
            end

            if machine.has_key?('ansible')
                machine['ansible'].each do |playbook|
                    node.vm.provision :ansible do |ansible|

                        ansible.playbook = playbook['playbook_name']
                        
                        if playbook.has_key?('limit')
                            ansible.limit = playbook['limit']
                        end

                        if playbook.has_key?('vault_password_file')
                            ansible.vault_password_file = playbook['vault_password_file']
                        end

                        if playbook.has_key?('groups')
                            ansible.groups = playbook['groups']
                        end

                        if playbook.has_key?('tags')
                            ansible.tags = playbook['tags']
                        end

                        if playbook.has_key?('host_vars_file')
                            ansible.host_vars = YAML.load_file(playbook['host_vars_file'])
                        end

                        if playbook.has_key?('inventory_file')
                            ansible.inventory_path = playbook['inventory_file']
                        end
                    end
                end
            end
        end
    end
end
