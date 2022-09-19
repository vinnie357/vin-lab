# nfs storage provisioner

https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner

```bash
sudo apt install nfs-common

helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm repo update
helm install --namespace kube-system nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=storage.vin-lab.com \
    --set nfs.path=/volume2/metal-k8s-0
kubectl -n kube-system describe storageclasses nfs-client
kubectl -n kube-system patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl -n kube-system describe storageclasses nfs-client
```
