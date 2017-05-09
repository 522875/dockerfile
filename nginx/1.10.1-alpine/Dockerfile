FROM nginx:1.10.1-alpine
MAINTAINER chenyongbing

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main/" > /etc/apk/repositories
RUN apk add tzdata --no-cache && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  && echo "Asia/Shanghai" > /etc/timezone
ENV LANG  en_US.UTF-8
