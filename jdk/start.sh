set -e



###################################
#(函数)随机可用端口
#
#说明：
#1. 随机49153 - 65535 之间的可用端口
###################################
check_port() {
#        netstat -tlpn | grep "\b$1\b" >> /dev/null
        netstat -na | grep "\b$1\b" >> /dev/null
}
rand_port() {
    min=49153
    max=65535
    num=$((33676/($max-$min)))
    port=$(($RANDOM/$num+$min-1))
    if check_port $port;then
        rand_port
    fi
}
rand_port

full_container_id=`cat /proc/self/cgroup | grep "cpu:/" | sed 's/\([0-9]\):[^\:]*cpu:\/docker\///g'`
container_id=`expr substr "$full_container_id" 1 12`
hostname=`hostname`
ip=`cat /etc/hosts| grep ${hostname} | awk '{print $1}'`

if [ -z $ip ]; then
    echo "$hostname must in /etc/hosts"
    exit 1;
fi

if [ ! -z `echo $KS_PROJECT_NAME | grep "auth\-rpc"` ];then
    item="app.zookeeper.server.export"
elif [ ! -z `echo $KS_PROJECT_NAME | grep "\-rpc"` ];then
    item="soa.server.port"
else
    item="server.port"
fi

JAVA_OPTS="-ms128m -mx512m -Xmn256m -Djava.awt.headless=true -XX:MaxPermSize=128m -Duser.timezone=Asia/Shanghai"


echo "curl -X PUT ${KS_ETCD_SERVER}/v2/keys/${KS_SYS_ENV}/nginx/${KS_PROJECT_NAME}/online/$container_id -d value=$ip:$port"
curl -X PUT ${KS_ETCD_SERVER}/v2/keys/${KS_SYS_ENV}/nginx/${KS_PROJECT_NAME}/online/$container_id -d value=$ip:$port

echo "java $JAVA_OPTS -D server.port=$port -Dloader.path=/data/$KS_PROJECT_NAME/resources -jar /data/$KS_PROJECT_NAME/libs/*.jar"
java -Dproject.build.version $KS_PROJECT_VERSION $JAVA_OPTS -D$item=$port -Dloader.path=/data/$KS_PROJECT_NAME/resources -jar /data/$KS_PROJECT_NAME/libs/*.jar > /dev/null  2>&1
