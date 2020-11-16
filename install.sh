#!/bin/bash

#安装Docker
#安装依赖包
yum -y install yum-utils device-mapper-persistent-data lvm2
#添加yum仓库
yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# 安装指定版本的Docker-CE:
# yum list docker-ce.x86_64 --showduplicates | sort -r
#安装docker
yum install -y docker-ce-19.03.5 docker-ce-cli-19.03.5 containerd.io

#创建docker配置文件
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

cat >>  /etc/sysctl.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl -p

#创建docker目录
mkdir -p /data/docker

#启动docker
systemctl daemon-reload
systemctl enable docker
systemctl start docker

docker info
