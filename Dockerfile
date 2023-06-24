#FROM registry.access.redhat.com/ubi8/ubi
FROM quay.io/centos/centos:stream8

ENV TZ Asia/Tokyo

RUN dnf install -y epel-release \
  && dnf module -y enable nginx:1.20 \
  && dnf install -y supervisor postfix nginx \
  && dnf install -y https://github.com/jfut/nginx-module-fancyindex-rpm/releases/download/v0.5.2-1/nginx-module-fancyindex-0.5.2-1.module_el8.1.20.x86_64.rpm \
  && dnf clean all

RUN useradd docker \
  && mkdir -m 777 /post \
  && postconf -e default_transport=fs_mail \
  && postconf -e inet_interfaces=all \
  && postconf -e inet_protocols=ipv4 \
  && postconf -e maillog_file=/dev/stdout \
  && postconf -e mynetworks=0.0.0.0/0 \
  && postconf -e smtpd_peername_lookup=no \
  && postconf -e debug_peer_level=2 \
  && postconf -e debug_peer_list="0.0.0.0" \
  && echo 'fs_mail unix - n n - - pipe flags=F user=docker argv=tee /post/${sender}_${recipient}_${queue_id}.txt' >> /etc/postfix/master.cf \
  && echo 'postlog   unix-dgram n  -       n       -       1       postlogd' >> /etc/postfix/master.cf \
  && postalias /etc/aliases \
  && newaliases

COPY supervisord.conf /etc/supervisord.d/supervisord.ini
COPY nginx.conf /etc/nginx/nginx.conf

CMD /usr/bin/supervisord -c /etc/supervisord.conf
#VOLUME /post
EXPOSE 25 80

