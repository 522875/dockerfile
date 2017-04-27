set -e
JAVA_OPTS="-ms128m -mx1024m  -Djava.awt.headless=true -XX:MaxPermSize=128m -Duser.timezone=Asia/Shanghai"
java -Dproject.build.version=$KS_PROJECT_VERSION -Dserver.port=$KS_PROJECT_PORT $JAVA_OPTS  -Dloader.path=/data/$KS_PROJECT_NAME/resources -jar /data/$KS_PROJECT_NAME/libs/*.jar
