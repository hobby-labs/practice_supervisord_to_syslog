# practice_supervisord_to_syslog

```
docker run --rm -it -p 514:514/udp -p 601:601 --name syslog-ng balabit/syslog-ng

docker run --rm --name ubuntu --hostname ubuntu -ti ubuntu:20.04 bash
docker exec -ti ubuntu bash
DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor nginx syslog-ng

cat << EOF > /etc/supervisor/conf.d/supervisord.conf
[program:nginx]
command=nginx -g 'daemon off;'
user=monadmin
autorestart=true
stdout_syslog=true
stderr_syslog=true
EOF
```

