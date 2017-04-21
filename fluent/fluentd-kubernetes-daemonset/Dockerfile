FROM fluent/fluentd-kubernetes-daemonset:elasticsearch
COPY add_source.py /
COPY ks.conf /fluentd/etc/
RUN sed -i "s/kubernetes.conf/ks.conf/g" /fluentd/etc/fluent.conf 
