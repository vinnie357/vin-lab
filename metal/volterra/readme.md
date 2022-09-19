# volt site

https://www.volterra.io/docs/how-to/site-management/create-k8s-site

## volterra calls the sites "customer edge" so ce

## requires

- worker nodes enabled with at least 8gigs of huge pages avaliable.
  at 2Mb pages

  sysctl

  ```bash
  # switch to root for the echo
  sudo su -
  # append hugepage limit to /etc/sysctl.conf
  echo 'vm.nr_hugepages = 4096' >> /etc/sysctl.conf
  # return to normal user
  exit
  # verify settings
  sudo sysctl -p
  # reboot
  sudo reboot
  # verify
  cat /proc/meminfo | grep Huge
  AnonHugePages:         0 kB
  ShmemHugePages:        0 kB
  FileHugePages:         0 kB
  HugePages_Total:    4096
  HugePages_Free:     4096
  HugePages_Rsvd:        0
  HugePages_Surp:        0
  Hugepagesize:       2048 kB
  Hugetlb:         8388608 kB
  ```

  ```grub
  #/etc/default/grub
  GRUB_CMDLINE_LINUX="hugepages=4096"
  sudo update-grub
  sudo reboot
  ```

- site token
- dynamic pvc default provisioner in cluster see [storage](../storage/readme.md)

```bash
kubectl apply -f ce_k8s.yml
# watch for containers
kubectl -n ves-system describe pods ver-0  | grep -B 10 "Last State"

```
