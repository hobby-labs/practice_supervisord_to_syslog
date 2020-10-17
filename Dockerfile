FROM ubuntu:20.04
LABEL maintainer "Tsutomu Nakamura<tsuna.0x00@gmail.com>"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor nginx syslog-ng curl && \
        apt-get clean && \
        ln -sf /dev/stdout /var/log/nginx/access.log && \
        ln -sf /dev/stderr /var/log/nginx/error.log && \
        echo '[supervisord]\n\
nodaemon = true\n\
\n\
[program:nginx]\n\
command = nginx -g "daemon off;"\n\
user = root\n\
autorestart = true\n\
stdout_logfile = syslog\n\
stderr_logfile = syslog' > /etc/supervisor/conf.d/supervisord.conf

COPY syslog-ng.conf /etc/syslog-ng/syslog-ng.conf

ENTRYPOINT ["/usr/bin/supervisord"]

