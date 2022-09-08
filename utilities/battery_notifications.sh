#!/home/k8x1d/.guix-profile/bin/bash
# inspired by https://askubuntu.com/questions/518928/how-to-write-a-script-to-listen-to-battery-status-and-alert-me-when-its-above
warning_level=30
critic_level=10
while true
do
   battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
   battery_charging=`acpi -b | grep -c 'Charging'`
   if [ $battery_level -le $warning_level ] && [ $battery_level -gt $critic_level ] && [ $battery_charging -eq "0" ]; then
       dunstify "Battery getting low..." "$battery_level% left"    
   elif [ $battery_level -le $critic_level ] && [ $battery_charging -eq "0" ]; then
       dunstify "Critically low battery level..." "$battery_level% left"    
   fi
    sleep 300 # 300 seconds or 5 minutes
done
