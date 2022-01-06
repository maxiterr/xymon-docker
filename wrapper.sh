apachectl start
runuser -u xymon /opt/xymon/server/bin/xymon.sh start

while true; do
  sleep 10
done
