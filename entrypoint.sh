#!/bin/bash

###################
#WARNING needs to be saved als LT end of line file
###################

# Set password for VNC

mkdir -p /root/.vnc/
echo $VNCPWD | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# Set password for VNC as user hacker
su hacker -c "mkdir -p /home/hacker/.vnc/"
su hacker -c "echo $VNCPWD | vncpasswd -f > /home/hacker/.vnc/passwd"
su hacker -c "chmod 600 /home/hacker/.vnc/passwd"

# Start VNC server as user hacker
su hacker -c "vncserver :0 -rfbport $VNCPORT -geometry $VNCDISPLAY -depth $VNCDEPTH \
  > /dev/null 2>&1 &"

# Start noVNC server as user hacker

su hacker -c "/usr/share/novnc/utils/launch.sh --listen $NOVNCPORT --vnc localhost:$VNCPORT \
  > /dev/null 2>&1 &"

echo "#!/bin/sh

autocutsel -fork
xrdb "$HOME/.Xresources"
xsetroot -solid grey
#x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
#x-window-manager &
# Fix to make GNOME work
export XKL_XMODMAP_DISABLE=1
/etc/X11/Xsession" > /home/hacker/.vnc/xstartup

chmod 777 /home/hacker/.vnc/xstartup

echo "Launch your web browser and open http://localhost:9020/vnc.html"

# Start shell
/bin/zsh && su - hacker