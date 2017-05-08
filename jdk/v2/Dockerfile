FROM java:8u92-jre-alpine
MAINTAINER chenyongbing

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main/" > /etc/apk/repositories
RUN apk add --no-cache curl ttf-dejavu
RUN apk add tzdata --no-cache && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  && echo "Asia/Shanghai" > /etc/timezone
COPY start.sh /data/start.sh
ENV LANG  en_US.UTF-8
CMD ["sh" , "/data/start.sh"]
