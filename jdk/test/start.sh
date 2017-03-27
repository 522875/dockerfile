set -e
JAVA_OPTS="-ms128m -mx512m -Xmn256m -Djava.awt.headless=true -XX:MaxPermSize=128m -Duser.timezone=Asia/Shanghai"
#java -Dproject.build.version=$KS_PROJECT_VERSION $JAVA_OPTS  -Dloader.path=/data/$KS_PROJECT_NAME/resources -jar /data/$KS_PROJECT_NAME/libs/*.jar > /dev/null  2>&1
java  -Dloader.path=/data/$KS_PROJECT_NAME/resources -jar /data/$KS_PROJECT_NAME/libs/*.jar
