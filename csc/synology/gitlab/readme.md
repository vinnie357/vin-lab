# gitlab ce

https://docs.gitlab.com/ee/install/docker.html

## password

```bash
docker exec -it gitlab_web_1 grep 'Password:' /etc/gitlab/initial_root_password
```
