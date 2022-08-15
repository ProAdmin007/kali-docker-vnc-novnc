#!/bin/bash

###################
#WARNING needs to be saved als LT end of line file
###################

# Set password for VNC

mkdir -p /root/.vnc/
echo $VNCPWD | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# Start VNC server
vncserver :0 -rfbport $VNCPORT -geometry $VNCDISPLAY -depth $VNCDEPTH \
  > /dev/null 2>&1 &

# Start noVNC server

/usr/share/novnc/utils/launch.sh --listen $NOVNCPORT --vnc localhost:$VNCPORT \
  > /dev/null 2>&1 &

echo "Launch your web browser and open http://local
# Start shell

/bin/bash
