FROM openresty/openresty

COPY nginx.conf /usr/local/openresty/nginx/conf/

COPY . /usr/local/openresty/nginx/abtesting/
VOLUME /usr/local/openresty/nginx/cert
VOLUME /usr/local/openresty/nginx/vhosts

EXPOSE 80