# gitlab ce

https://docs.gitlab.com/ee/install/docker.html

## password

```bash
docker exec -it gitlab_web_1 grep 'Password:' /etc/gitlab/initial_root_password
```

## reset password

https://cm-gitlab.stanford.edu/help/security/reset_root_password.md

```bash
ssh user@yourgitlab
# impersonate root
su - root
# connect to console
gitlab-rails console
# wait for postgres prompt
# set user properties
user = User.where(id: 1).first
user.password = 'secret_pass'
user.password_confirmation = 'secret_pass'
# save changes
user.save!
# exit

```
