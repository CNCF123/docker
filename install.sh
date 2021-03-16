#!/bin/bash

yum -y install yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum list docker-ce.x86_64 --showduplicates | sort -r

yum install -y docker-ce-19.03.15 docker-ce-cli-19.03.15 containerd.io


mkdir -p /etc/docker
cat > /etc/docker/daemon.json <<EOF 
{
  "insecure-registry": [
    "hub.docker.com"
  ],
  "registry-mirrors": ["https://5cs233bb.mirror.aliyuncs.com"],
  "graph": "/data/docker",
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF

mkdir -p /data/docker | true

cat >>  /etc/sysctl.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl -p

systemctl daemon-reload
systemctl enable docker
systemctl start docker

docker info
