#!/sbin/sh

SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=true
LATESTARTSERVICE=true
SKIPUNZIP=0

sleep 0.5
ui_print "                                                 "
ui_print "                                                 "
ui_print "                 Vexana tweaks                   "
ui_print " _______________________________________________ "
sleep 0.5
ui_print " "
ui_print " • Version         : v2.0"
ui_print " • Release Date    : 05-02-2025"
ui_print " • Owner           : @cream_oreo"
sleep 0.5
ui_print " "
ui_print " Device info:"
sleep 0.5
ui_print " • Brand           : $(getprop ro.product.system.brand) "
sleep 0.3
ui_print " • Device          : $(getprop ro.product.system.model) "
sleep 0.3
ui_print " • Processor       : $(getprop ro.product.board) "
sleep 0.3
ui_print " • Android Version : $(getprop ro.system.build.version.release) "
sleep 0.3
ui_print " • SDK Version     : $(getprop ro.build.version.sdk) "
sleep 0.3
ui_print " • Architecture    : $(getprop ro.product.cpu.abi) "
sleep 0.3
ui_print " • Kernel Version  : $(uname -r) "
sleep 0.3
ui_print "-------------------------------------------------"
sleep 0.1
ui_print " Thanks To:"
sleep 0.1
ui_print " • Allah swt"
sleep 0.1
ui_print " • @Ri_Butz"
sleep 0.1
ui_print " • @WeAreRavenS"
sleep 0.1
ui_print " • @aryaman895"
sleep 0.1
ui_print " • Ryujin⚡"
sleep 0.1
ui_print " • Electric1447"
sleep 0.1
ui_print " • All my friends who contributed to the"
ui_print "   development of the project and many others."
sleep 0.1
ui_print "-------------------------------------------------"
ui_print " "
sleep 0.2
ui_print "                                                 "
ui_print "           TELEGRAM : Ryuzee_project             "
ui_print "              ID    : @exnz256                   "
ui_print "                                                 "
ui_print "                                                 "
ui_print "                                                 "
sleep 1

# Extract module files
ui_print "- Extracting module files"
unzip -o "$ZIPFILE" 'addon/*' -d $MODPATH >&2
unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
unzip -o "$ZIPFILE" post-fs-data.sh -d $MODPATH >&2
unzip -o "$ZIPFILE" module.prop -d $MODPATH >&2

# Run addons
if [ "$(ls -A $MODPATH/addon/*/install.sh 2>/dev/null)" ]; then
  ui_print "- Running Addons"
  for i in $MODPATH/addon/*/install.sh; do
    ui_print "  Running $(echo $i | sed -r "s|$MODPATH/addon/(.*)/install.sh|\1|")..."
    . $i
  done
fi

ui_print "" 
ui_print "  Volume Key Selector to select options:"
ui_print "  1) Disable thermal engine"
ui_print "  2) Custom DNS config"
ui_print "  3) Fast charging"
ui_print "  4) Pie chromatix libs patcher (only for ginkgo)"
ui_print "  5) Fake encryption flag ROM"
ui_print "  6) Zram size"
ui_print "  7) Swap ram size"
ui_print "  8) .kl (keylayout) for Dualshock 4/3 and etc"
ui_print "  9) Built-in magisk busybox"
ui_print ""
ui_print "  Button Function:"
ui_print "  • Volume + (Next)"
ui_print "  • Volume - (Select)"
ui_print ""
sleep 1

# Disable thermal
ui_print "  ⚠️Disable thermal engine >"
ui_print "    1. Yes"
ui_print "    2. No"
ui_print ""
ui_print "    Select:"
A=1
while true; do
    ui_print "    $A"
    if $VKSEL; then
        A=$((A + 1))
    else
        break
    fi
    if [ $A -gt 2 ]; then
        A=1
    fi
done
ui_print "    Selected: $A"
case $A in
    1 ) TEXT1="Yes"; sed -i '/#enable_thermal_service/s/.*/enable_thermal_service/' $MODPATH/service.sh; sed -i '/#disable_thermal_service/s/.*/disable_thermal_service/' $MODPATH/service.sh;;
    2 ) TEXT1="No"; rm -rf $MODPATH/system/vendor/bin; rm -rf $MODPATH/system/vendor/etc;;
esac
ui_print "    $TEXT1"
ui_print ""

# DNS config
  # The following is the default implementation: extract $ZIPFILE/system to $MODPATH
  # Extend/change the logic to whatever you want
  ui_print "- Extracting module files"
  mods=/data/adb/modules

AUTH="@WᴇAʀᴇRᴀᴠᴇɴS"
TVERSION="v𝟙.𝟘"
TDESC="Cᴜsᴛᴏᴍ DNS Cᴏɴғɪɢ & Nᴇᴛᴡᴏʀᴋ Tᴡᴇᴀᴋs." 
ui_print "   "
ui_print "   "
  ui_print "-  ⚠️Custom DNS Config >"
  ui_print "     1. AdGuard DNS "
  ui_print "     2. Alternate DNS "
  ui_print "     3. Century Link DNS "
  ui_print "     4. Clean Browsing DNS "
  ui_print "     5. Cloudflare DNS "
  ui_print "     6. Comodo Secure DNS "
  ui_print "     7. Google DNS "
  ui_print "     8. Next DNS "
  ui_print "     9. Open DNS "
  ui_print "    10. Quad9 DNS "
  ui_print "    11. Yandex DNS "
  ui_print "   "
ui_print "  Select DNS Config :"
DN=1
while true; do
    ui_print "    $DN"
    if $VKSEL; then
        DN=$((DN + 1))
    else
        break
    fi
    if [ $DN -gt 11 ]; then
        DN=1
    fi
done
ui_print "    Selected: $DN"
#
case $DN in
	1 ) MODS1="AdGuard DNS"; echo "Adguard_DNS" > $MODPATH/dns; NAME="𝐴𝑑𝐺𝑢𝑎𝑟𝑑 𝐷𝑁𝑆";;
	2 ) MODS1="Alternate DNS"; echo "Alternate_DNS" > $MODPATH/dns; NAME="𝐴𝑙𝑡𝑒𝑟𝑛𝑎𝑡𝑒 𝐷𝑁𝑆";;
	3 ) MODS1="Century Link DNS"; echo "CenturyLink_DNS" > $MODPATH/dns; NAME="𝐶𝑒𝑛𝑡𝑢𝑟𝑦 𝐿𝑖𝑛𝑘 𝐷𝑁𝑆";;
	4 ) MODS1="Clean Browsing DNS"; echo "CleanBrowsing_DNS" > $MODPATH/dns; NAME="𝐶𝑙𝑒𝑎𝑛 𝐵𝑟𝑜𝑤𝑠𝑖𝑛𝑔 𝐷𝑁𝑆";;
	5 ) MODS1="Cloudflare DNS"; echo "Cloudflare_DNS" > $MODPATH/dns; NAME="𝐶𝑙𝑜𝑢𝑑𝑓𝑙𝑎𝑟𝑒 𝐷𝑁𝑆";;
	6 ) MODS1="Comodo Secure DNS"; echo "ComodoSecure_DNS" > $MODPATH/dns; NAME="𝐶𝑜𝑚𝑜𝑑𝑜 𝑆𝑒𝑐𝑢𝑟𝑒 𝐷𝑁𝑆";;
	7 ) MODS1="Google DNS"; echo "Google_DNS" > $MODPATH/dns; NAME="𝐺𝑜𝑜𝑔𝑙𝑒 𝐷𝑁𝑆";;
	8 ) MODS1="Next DNS"; echo "Next_DNS" > $MODPATH/dns; NAME="𝑁𝑒𝑥𝑡 𝐷𝑁𝑆";;
	9 ) MODS1="Open DNS"; echo "Open_DNS" > $MODPATH/dns; NAME="𝑂𝑝𝑒𝑛 𝐷𝑁𝑆";;
	10 ) MODS1="Quad9 DNS"; echo "Quad9_DNS" > $MODPATH/dns; NAME="𝑄𝑢𝑎𝑑9 𝐷𝑁𝑆";;
	11 ) MODS1="Yandex DNS"; echo "Yandex_DNS" > $MODPATH/dns; NAME="𝑌𝑎𝑛𝑑𝑒𝑥 𝐷𝑁𝑆";;
esac
ui_print "  $MODS1 "
ui_print "   "
ui_print "   "
cp -af $TMPDIR/weareravens.sh $MODPATH/weareravens.sh

# Fast Charging 
ui_print "  ⚠️Fast charging options >"
ui_print "    1. Do not install it by default"
ui_print "    2. 33w 6000mA⚡"
ui_print ""
ui_print "    Select:"
CH=1
while true; do
    ui_print "  $CH"
    if $VKSEL; then
        CH=$((CH + 1))
    else
        break
    fi
    if [ $CH -gt 2 ]; then
        CH=1
    fi
done
ui_print "  Selected: $CH"
case $CH in
    1 ) FSC="Default"; rm -rf $MODPATH/system/etc;;
    2 ) FSC="33w 6000mA⚡"; sed -i '/#fc/s/.*/fc/' $MODPATH/service.sh;;
esac
ui_print "    $FSC"
ui_print ""

# Pie Chromatix libs
ui_print "  ⚠️ Pie chromatix libs patcher (only for ginkgo) >"
ui_print "    1. Skip"
ui_print "    2. Install"
ui_print ""
ui_print "    Select:"
PC=1
while true; do
    ui_print "  $PC"
    if $VKSEL; then
        PC=$((PC + 1))
    else
        break
    fi
    if [ $PC -gt 2 ]; then
        PC=1
    fi
done
ui_print "  Selected: $PC"
case $PC in
    1 ) PCL="Skip"; rm -rf $MODPATH/system/vendor/lib;;
    2 ) PCL="Install";;
esac
ui_print "    $PCL"
ui_print ""

# Fake encryption
ui_print "  ⚠️ Fake encryption flag ROM >"
ui_print "    1. Do not install it by default"
ui_print "    2. Install"
ui_print ""
ui_print "    Select:"
FE=1
while true; do
    ui_print "  $FE"
    if $VKSEL; then
        FE=$((FE + 1))
    else
        break
    fi
    if [ $FE -gt 2 ]; then
        FE=1
    fi
done
ui_print "  Selected: $FE"
case $FE in
    1 ) FEF="Default";;
    2 ) FEF="Install"; sed -i '/#ro.crypto.state=encrypted/s/.*/ro.crypto.state=encrypted/' $MODPATH/system.prop;;
esac
ui_print "    $FEF"
ui_print ""

# Zram
ui_print "  ⚠️Zram size >"
ui_print "    1. Default(using default zram from device)"
ui_print "    2. Disable"
ui_print "    3. 1024MB"
ui_print "    4. 1536MB"
ui_print "    5. 2048MB"
ui_print "    6. 2560MB"
ui_print "    7. 3072MB"
ui_print "    8. 4096MB"
ui_print "    9. 5120MB"
ui_print "   10. 6144MB"
ui_print ""
ui_print "    Select:"
B=1
while true; do
    ui_print "    $B"
    if $VKSEL; then
        B=$((B + 1))
    else
        break
    fi
    if [ $B -gt 10 ]; then
        B=1
    fi
done
ui_print "    Selected: $B"
case $B in
    1 ) TEXT2="Default";;
    2 ) TEXT2="Disable"; sed -i '/#change_zram/s/.*/disable_zram/' $MODPATH/service.sh;;
    3 ) TEXT2="1024MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=1025M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    4 ) TEXT2="1536MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=1537M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    5 ) TEXT2="2048MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=2049M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    6 ) TEXT2="2560MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=2561M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    7 ) TEXT2="3072MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=3072M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    8 ) TEXT2="4096MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=4097M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    9 ) TEXT2="5120MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=5121M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    10 ) TEXT2="6144MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=6145M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
esac
ui_print "    $TEXT2"
ui_print ""

# Swap ram
ui_print "  ⚠️Swap RAM size >"
ui_print "    1. Disable"
ui_print "    2. 1024MB"
ui_print "    3. 1536MB"
ui_print "    4. 2048MB"
ui_print "    5. 2560MB"
ui_print "    6. 3072MB"
ui_print "    7. 4096MB"
ui_print "    8. 5120MB"
ui_print "    9. 6144MB"
ui_print ""
ui_print "    Select:"
C=1
while true; do
    ui_print "    $C"
    if $VKSEL; then
        C=$((C + 1))
    else
        break
    fi
    if [ $C -gt 9 ]; then
        C=1
    fi
done
ui_print "    Selected: $C"
case $C in
    1 ) TEXT3="Disable";;
    2) TEXT3="1024MB"; sed -i '/SWAPSIZE=0/s/.*/SWAPSIZE=1048576/' $MODPATH/service.sh; sed -i '/#change_swap/s/.*/change_swap/' $MODPATH/service.sh;;
    3 ) TEXT3="1536MB"; sed -i '/SWAPSIZE=0/s/.*/SWAPSIZE=1572864/' $MODPATH/service.sh; sed -i '/#change_swap/s/.*/change_swap/' $MODPATH/service.sh;;
    4) TEXT3="2048MB"; sed -i '/SWAPSIZE=0/s/.*/SWAPSIZE=2097152/' $MODPATH/service.sh; sed -i '/#change_swap/s/.*/change_swap/' $MODPATH/service.sh;;
    5) TEXT3="2560MB"; sed -i '/SWAPSIZE=0/s/.*/SWAPSIZE=2621440/' $MODPATH/service.sh; sed -i '/#change_swap/s/.*/change_swap/' $MODPATH/service.sh;;
    6) TEXT3="3072MB"; sed -i '/SWAPSIZE=0/s/.*/SWAPSIZE=3145728/' $MODPATH/service.sh; sed -i '/#change_swap/s/.*/change_swap/' $MODPATH/service.sh;;
    7) TEXT3="4096MB"; sed -i '/SWAPSIZE=0/s/.*/SWAPSIZE=4194304/' $MODPATH/service.sh; sed -i '/#change_swap/s/.*/change_swap/' $MODPATH/service.sh;;
    8) TEXT3="5120MB"; sed -i '/SWAPSIZE=0/s/.*/SWAPSIZE=5242880/' $MODPATH/service.sh; sed -i '/#change_swap/s/.*/change_swap/' $MODPATH/service.sh;;
    9) TEXT3="6144MB"; sed -i '/SWAPSIZE=0/s/.*/SWAPSIZE=6291456/' $MODPATH/service.sh; sed -i '/#change_swap/s/.*/change_swap/' $MODPATH/service.sh;;
esac
ui_print "    $TEXT3"
ui_print ""

# (keylayout)
ui_print "  ⚠️Add .kl file (keylayout) for dualshock >"
ui_print "    1. Install"
ui_print "    2. Skip installation"
ui_print ""
ui_print "    Select:"
D=1
while true; do
    ui_print "    $D"
    if $VKSEL; then
        D=$((D + 1))
    else
        break
    fi
    if [ $D -gt 2 ]; then
        D=1
    fi
done
ui_print "    Selected: $D"
case $D in
    1 ) TEXT4="Install" ;;
    2 ) TEXT4="Skip installation"; rm -rf $MODPATH/system/usr;;
esac
ui_print "    $TEXT4"
ui_print ""

# Built-in busybox
ui_print "  ⚠️Built-in magisk busybox >"
ui_print "    1. Enable"
ui_print "    2. Disable"
ui_print ""
ui_print "    Select:"
F=1
while true; do
    ui_print "    $F"
    if $VKSEL; then
        F=$((F + 1))
    else
        break
    fi
    if [ $F -gt 2 ]; then
        F=1
    fi
done
ui_print "    Selected: $F"
case $F in
    1 ) TEXT6="Enable"; sed -i '/#install_busybox/s/.*/install_busybox/' $MODPATH/post-fs-data.sh;;
    2 ) TEXT6="Disable";;
esac
ui_print "    $TEXT6"
ui_print ""

sleep 2

ui_print "  Your settings:"
ui_print "  1) Disable thermal engine     : $TEXT1"
ui_print "  2) Custom DNS config          : $MODS1"
ui_print "  3) Fast charging              : $FSC"
ui_print "  4) Pie chromatix libs patcher : $PCL"
ui_print "  5) Fake encryption flag ROM   : $FEF"
ui_print "  6) Zram size                  : $TEXT2"
ui_print "  7) Swap ram size              : $TEXT3"
ui_print "  8) Add .kl file (keylayout)   : $TEXT4"
ui_print "  9) Built-in magisk busybox    : $TEXT6"
ui_print " "
ui_print "#####################################################"
ui_print "- Apply options"

# Set permissions
ui_print "- Setting permissions"
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/system/bin 0 0 0755 0755

ui_print " "
sleep 1

# Clean up
ui_print "- Clean up"
sleep 0.5
find $MODPATH/* -maxdepth 0 \
              ! -name 'dns' \
              ! -name 'module.prop' \
              ! -name 'post-fs-data.sh' \
              ! -name 'weareravens.sh' \
              ! -name 'service.sh' \
              ! -name 'system.prop' \
              ! -name 'system' \
                -exec rm -rf {} \;

