FROM centos:6
RUN yum update -y
RUN rpm -ivh https://mirrors.tuna.tsinghua.edu.cn/epel/epel-release-latest-6.noarch.rpm && \
    yum install -y salt-minion
CMD service salt-minion start && tail -f /var/log/salt/minion
