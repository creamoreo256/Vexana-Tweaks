#!/sbin/sh
MODDIR=${0%/*}

# Busybox functions
install_busybox()
{
if [ ! -e $MODDIR/system/bin/busybox ]; then
  cp -f /data/adb/magisk/busybox $MODDIR/system/bin
  chown 0:0 $MODDIR/system/bin/busybox
  chmod 775 $MODDIR/system/bin/busybox
  chcon u:object_r:system_file:s0 $MODDIR/system/bin/busybox
  $MODDIR/system/bin/busybox --install -s $MODDIR/system/bin/
  for sd in /system/bin/*; do
     rm -f $MODDIR/${sd}
  done
fi
}

# Install built-in magisk busybox
#install_busybox
