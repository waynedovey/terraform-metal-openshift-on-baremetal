#!/bin/bash
yum install -y nginx jq nfs-utils haproxy squid mlocate git unzip tar 
yum install -y epel-release
yum install -y ansible 
sed -i "s|location / {|location / {\n             autoindex on;|g" /etc/nginx/nginx.conf
sed -i "s/80/8080/g" /etc/nginx/nginx.conf

sed -i "s/deny/allow/g" /etc/squid/squid.conf
rm -rf /usr/share/nginx/html/index.html
rm -rf /usr/share/nginx/html/poweredby.png
rm -rf /usr/share/nginx/html/nginx-logo.png

wget https://github.com/kubevirt/kubevirt/releases/download/v0.47.1/virtctl-v0.47.1-linux-amd64 -O /usr/local/bin/virtctl
chmod +x /usr/local/bin/virtctl

cat << EOF > /root/requirements.yml
collections:
- name: community.libvirt
- name: community.kubernetes
EOF

ansible-galaxy collection install -r /root/requirements.yml

pip3 install openshift

mkdir -p /kubeconfig
touch /kubeconfig/ocp-infra1

systemctl enable nginx
systemctl start nginx

systemctl enable haproxy
systemctl start haproxy

systemctl enable squid
systemctl start squid

systemctl enable nfs-server.service
systemctl start nfs-server.service

mkdir -p /mnt/nfs/ocp
chmod -R 777 /mnt/nfs/ocp