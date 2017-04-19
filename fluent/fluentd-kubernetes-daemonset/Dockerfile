FROM fluent/fluentd-kubernetes-daemonset:elasticsearch

COPY filter /tmp/
RUN cat /tmp/filter >> /fluentd/etc/fluent.conf

