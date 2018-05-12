#/bin/sh

#usage is  ./check_apk_package_name.sh path_to_apk

package=$(aapt dump badging "$*" | awk '/package/{gsub("name=|'"'"'","");  print $2}')
activity=$(aapt dump badging "$*" | awk '/activity/{gsub("name=|'"'"'","");  print $2}')    echo
echo "   file : $1"
echo "package : $package"
echo "activity: $activity"

