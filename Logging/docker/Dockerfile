FROM logstash:8.10.2
COPY logstash.conf /etc/logstash/conf.d/logstash.conf
COPY logstash.yml /usr/share/logstash/config/logstash.yml
COPY logrotate /etc/logrotate.d/agnos
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -y logrotate
RUN chmod 644 /etc/logrotate.d/agnos
RUN chown root:root /etc/logrotate.d/agnos
USER logstash
RUN mkdir /usr/share/logstash/data/agnos/
