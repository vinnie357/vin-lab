# metal kubespray

## from devcontainer

```bash
git clone https://github.com/kubernetes-sigs/kubespray.git
# change to kubespray
cd kubespray
# Install dependencies from ``requirements.txt``
sudo pip3 install -r requirements.txt

# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster

# Update Ansible inventory file with inventory builder
list="nuc1 nuc2 nuc3"
for item in $list; do IPS+="$(dig $item +short) " ; done
echo $IPS
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Review and change parameters under ``inventory/mycluster/group_vars``
cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml

# Deploy Kubespray with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example writing SSL keys in /etc/,
# installing packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
#
# add ssh key to session
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
# test
# -u username with sudo priv, -K ask for sudo pw
ansible-playbook -i inventory/mycluster/hosts.yaml -u mysshkeyusername -K --become --become-user=root cluster.yml --check
# run
ansible-playbook -i inventory/mycluster/hosts.yaml -u mysshkeyusername -K  --become --become-user=root cluster.yml
# firewall
# if your lazy like me, otherwise create rulesets for the daemons
sudo ufw disable
```

## tests

```bash
#network
kubectl run myshell1 -it --rm --image busybox -- sh
hostname -i
# launch myshell2 in separate terminal (see next code block) and ping the hostname of myshell2
ping <hostname myshell2>

#deployment
kubectl create namespace dev
kubectl create deployment nginx --image=nginx -n dev
kubectl expose deployment nginx --port 80 --type ClusterIP -n dev
kubectl run curly -it --rm --image curlimages/curl:7.70.0 -- /bin/sh
curl --head http://nginx.dev:80

kubectl delete deployment nginx -n dev
kubectl delete svc/nginx -n dev
kubectl delete namespace dev
```

## update

```bash
ansible-playbook -i inventory/mycluster/hosts.yaml -u mysshkeyusername -K  --become --become-user=root upgrade-cluster.yml
```
