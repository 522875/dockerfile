FROM centos:6
RUN yum update -y
RUN rpm -ivh https://mirrors.tuna.tsinghua.edu.cn/epel/epel-release-latest-6.noarch.rpm &&\
    yum install -y salt-master
CMD service salt-master start && tail -f /var/log/salt/master
