#!/bin/bash

printf "\nStart libvirtd\n"
systemctl enable libvirtd
systemctl start libvirtd

export LIBGUESTFS_BACKEND=direct

printf "\nConverting vm to tar file\n"
virt-tar-out --verbose -a CentOS-7-x86_64-GenericCloud-1711.qcow2  / - | gzip --best > centos7.tgz

# TODO: Variablize this script
