
chown xymon:xymon /opt/xymon/data
chown xymon:xymon /opt/xymon/server/www

if [ -f /opt/xymon-backup/inialized ]; then
  cp -a /opt/xymon-backup/* /opt/xymon/
else
  if [ ! -f /opt/xymon/inialized ]; then
    cp -a /opt/xymon_init/* /opt/xymon/
    touch /opt/xymon/inialized
  fi
fi

apachectl start
runuser -u xymon /opt/xymon/server/bin/xymon.sh start

while true; do
  sleep 600
  cp -a /opt/xymon/* /opt/xymon-backup/
done
