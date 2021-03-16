### docker添加http代理
##### 添加网络代理配置文件
`vim /etc/systemd/system/docker.service.d/http-proxy.conf`

##### 加入如下配置

[Service]
Environment="HTTP_PROXY=http://proxy-addr:proxy-port" "HTTPS_PROXY=http://proxy-addr:proxy-port" "NO_PROXY=localhost,127.0.0.1,docker-registry.somecorporation.com"


##### 载配置并重启dockers服务
`systemctl daemon-reload`

`systemctl restart docker`
