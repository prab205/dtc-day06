sudo kubeadm init \
        --control-plane-endpoint=$(curl -s ifconfig.me) \
        --apiserver-cert-extra-sans=$(curl -s ifconfig.me) \
        --pod-network-cidr="192.168.0.0/16" \
        --node-name=$(hostname -s) \
        --ignore-preflight-errors Swap \
        --ignore-preflight-errors NumCPU \
        --ignore-preflight-errors Mem 

kubectl get --raw='/readyz?verbose'



wget -P /tmp/ https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
sed -i 's/"Network": "10.244.0.0\/16"/"Network": "192.168.0.0\/16"/g' /tmp/kube-flannel.yml

kubectl apply -f '/tmp/kube-flannel.yml'
