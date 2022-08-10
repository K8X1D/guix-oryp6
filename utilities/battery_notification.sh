# inspired by https://askubuntu.com/questions/518928/how-to-write-a-script-to-listen-to-battery-status-and-alert-me-when-its-above

warning_level=25
critic_level=10

while true
do
   battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
   if [ $battery_level -le $warning_level ] && [ $battery_level -gt $critic_level ]; then
       dunstify "Battery getting low..." "$battery_level% left"    
   elif [ $battery_level -le $critic_level ]; then
       dunstify "Critically low battery level..." "$battery_level% left"    
   fi
    sleep 300 # 300 seconds or 5 minutes
done
