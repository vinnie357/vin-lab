# dev vault

https://github.com/hashicorp/vault-helm

```bash
helm repo add hashicorp https://helm.releases.hashicorp.com
#"hashicorp" has been added to your repositories
#https://github.com/hashicorp/vault-helm/blob/master/values.yaml
helm install vault hashicorp/vault --dry-run --debug --set ingress.enabled=true --set service.type=NodePort
helm upgrade vault hashicorp/vault --set ingress.enabled=true --set ui.serviceType="NodePort" --set service.type=NodePort -set dev.enabled=true
```
