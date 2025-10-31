# easy_nginx_manage

This is a easy way to run Nginx Proxy Manager.

```bash
git clone https://github.com/d1vai/easy_nginx_manage.git
cd easy_nginx_manage
sudo usermod -aG docker ubuntu && newgrp docker
sh nginx_manage_run.sh
```

if you use yum:
```bash
git clone https://github.com/d1vai/easy_nginx_manage.git
cd easy_nginx_manage
sudo usermod -aG docker ec2-user && newgrp docker
sh yum_manage_nginx_run.sh
```

change ec2-user to your sever login username

init username: admin@example.com
init pwd: changeme
