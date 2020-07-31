# vagrant-ansible-microk8s

## Introduction

A tools for testing systems deployment automation on a local machine.

The demo is a FastAPI application deployed on a Microk8s cluster, which runs on KVM virtual machine provisioned by Vagrant and a set of Ansible playbooks.

## How to use

Clone the repository on your machine and start provisioning VM(s) with Vagrant:
~~~
git clone https://github.com/oinqu/vagrant-ansible-microk8s.git
cd vagrant-ansible-microk8s
vagrant up
~~~

After it finishes, the FastAPI demo app will be accessible via localhost:8080

## Requirements:
- Qemu-KVM, Libvirt
- Vagrant >= 2.2.5
- vagrant-libvirt plugin
- Ansible >= 2
- Python >= 3

Tested on setup:
- Ubintu 20.04 LTS (Focal Fossa)
- QEMU-KVM 4.2.0 (Debian 1:4.2-3ubuntu6.2), libvirtd (libvirt) 6.0.0
- Vagrant 2.2.9, vagrant-libvirt (0.1.2, global)
- Ansible 2.9.6, Python 3.8.2
