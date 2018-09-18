From centos
RUN yum update -y && yum install wget php php-pdo php-pdo_mysql gcc unzip -y
RUN sed -i "s/; extension_dir = \".\/\"/extension_dir = \"\/usr\/lib64\/php\/modules\/\"/g" /etc/php.ini
RUN echo "extension=pdo.so" > /etc/php.d/pdo.ini
RUN cd /tmp && curl http://dl.cnezsoft.com/zentao/10.3.1/ZenTaoPMS.10.3.1.zip -o ZenTaoPMS.10.3.1.zip &&\
    unzip ZenTaoPMS.10.3.1.zip && mv zentaopms /var/www/html/
CMD systemctl httpd start && tail -f /var/log/httpd/access_log
