#!/system/bin/sh

# Wait till device boot process completes
while [ "$(getprop sys.boot_completed)" != "1" ]; do
	sleep 1
done

{
    while true; do
        resetprop -n init.svc.adbd stopped
        resetprop -n sys.usb.ffs.ready 0
        resetprop -n sys.usb.state mtp
        resetprop -n sys.usb.config mtp
        resetprop -n persist.sys.usb.reboot.func mtp
        sleep 1;
    done
} &

sleep 3

# Path
MODDIR=${0%/*}

$MODDIR/weareravens.sh

# Variables
ZRAMSIZE=0
SWAPSIZE=0

# Thermal engine
disable_thermal_service()
{
  stop android.thermal-hal
  stop debug_pid.sec-thermal-1-0
  stop mi_thermald
  stop thermal
  stop thermal-engine
  stop thermal_mnt_hal_service
  stop thermal-hal
  stop thermald
  stop thermalloadalgod
  stop thermalservice
  stop sec-thermal-1-0
  stop vendor.thermal-hal-1-0
  stop vendor.semc.hardware.thermal-1-0
  stop vendor-thermal-1-0
  stop vendor.thermal-engine
  stop vendor.thermal-manager
  stop vendor.thermal-hal-2-0
  stop vendor.thermal-symlinks
}

su -lp 2000 -c "cmd notification post -S bigtext -t 'Vexana notification' tag 'Wait a minute while applying the tweaks ⏳ '" >/dev/null 2>&1

sleep 3

# Zram functions
disable_zram()
{
    swapoff /dev/block/zram0
    echo "0" > /sys/class/zram-control/hot_remove
}

change_zram()
{
    sleep 5
    swapoff /dev/block/zram0
    echo "1" > /sys/block/zram0/reset
    echo "$ZRAMSIZE" > /sys/block/zram0/disksize
    mkswap /dev/block/zram0
    swapon /dev/block/zram0
}

# Swap functions
change_swap()
{
    if [ ! -e $MODDIR/swapram_installed ]; then
      if test -f "/data/swap"; then
        rm -f /data/swap
        dd if=/dev/zero of=/data/swap bs=1024 count=$SWAPSIZE
        mkswap /data/swap
        swapon /data/swap
      else
        dd if=/dev/zero of=/data/swap bs=1024 count=$SWAPSIZE
        mkswap /data/swap
        swapon /data/swap
      fi
      touch $MODDIR/swapram_installed
    else
      if test -f "/data/swap"; then
        swapon /data/swap
      else
        dd if=/dev/zero of=/data/swap bs=1024 count=$SWAPSIZE
        mkswap /data/swap
        swapon /data/swap
      fi
    fi
}

# Deepsleep functions
doze_default()
{
    dumpsys deviceidle enable
}

force_idle()
{
    dumpsys deviceidle force-idle 
}
sleep 1

# Fast charging function 
# This script will be executed in late_start service mode
fc()
{
  sh /system/etc/.nth_fc/.fc_main.sh
    if [ -f ${2} ]; then
        chmod 0666 ${2}
        echo ${1} > ${2}
        chmod 0444 ${2}
    fi
ext 5500000 /sys/class/power_supply/battery/constant_charge_current_max
}

# Thermal engine
disable_thermal_service

# Fast charging
#fc

# Zram function 
#change_zram

# Swap ram
#change_swap

# Doze mode
#doze_default

# Fstrim
fstrim -v /cache
fstrim -v /system
fstrim -v /vendor
fstrim -v /data
for sd in /storage/*; do
  fstrim -v ${sd}
done

sleep 3

su -lp 2000 -c "cmd notification post -S bigtext -t 'Vexana notification' tag 'Vexana tweaks is applied ✅ '" >/dev/null 2>&1
