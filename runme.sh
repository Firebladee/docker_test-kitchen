#!/bin/bash

printf "\nBuilding systemd container\n"
docker build -q -t centos7_systemd .

printf "\nRunning the systemd container\n"
docker run -d --privileged --name centos7_systemd -ti -e container=docker -v /sys/fs/cgroup:/sys/fs/cgroup centos7_systemd /usr/sbin/init 

printf "\nCopying across the vm image\n"
docker cp CentOS-7-x86_64-GenericCloud-1711.qcow2 centos7_systemd:/

printf "\nCopying across the the convert script\n"
docker cp ./script.sh centos7_systemd:/

printf "\nRunning the convert script\n"
docker -l error exec -it centos7_systemd /script.sh

printf "\nTakeing completed converted file from container\n"
docker cp centos7_systemd:/centos7.tgz .

printf "\nStopping and removing systemd docker image\n"
docker -l error stop centos7_systemd
docker -l error rm centos7_systemd
docker rmi centos7_systemd

printf "\nImport new image into docker\n"
docker import centos7.tgz test

printf "\nAll done.\n"
