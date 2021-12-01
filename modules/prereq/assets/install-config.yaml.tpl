apiVersion: v1
baseDomain: ${cluster_basedomain}
proxy:
  httpProxy: http://${bastion_priv_ip}:3128
  httpsProxy: http://${bastion_priv_ip}:3128
  noProxy: ${cluster_basedomain}
metadata:
  name: ${cluster_name}
networking:
  clusterNetworks:
  - cidr: 10.254.0.0/16
    hostPrefix: 24
  networkType: OpenShiftSDN
  serviceNetwork:
  - 172.30.0.0/16
compute:
- hyperthreading: Enabled
  name: worker
  replicas: ${count_compute}
controlPlane:
  hyperthreading: Enabled
  name: master
  replicas: ${count_controlplane}
platform:
  none: {}
sshKey: '${ssh_public_key}'