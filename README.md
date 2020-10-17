# practice_supervisord_to_syslog

Create macvlan network if it is not existed.

```
docker network create -d macvlan \
    --subnet=192.168.1.0/24 \
    --gateway=192.168.1.1 \
    -o parent=eth0 office_network
```

```
docker run --rm -it -p 514:514/udp -p 601:601 \
    --network office_network \
    --ip 192.168.1.91 \
    --dns 192.168.1.1 \
    --name dst-syslog-ng balabit/syslog-ng
```

```
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

