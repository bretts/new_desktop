#! /bin/bash
open -a 'Mission Control'
osascript -e 'delay 0.5' \
          -e 'tell application "System Events" to click (every button whose value of attribute "AXDescription" is "add desktop") of group 2 of group 1 of group 1 of process "Dock"' \
          -e 'delay 0.5' \
          -e 'tell application "System Events" to key code 53' \
          -e 'delay 0.5'

# Go to the first desktop on the left
osascript -e 'tell application "System Events" to key code 18 using control down'

# Go to the newest desktop on the right
#
# Note: A better solution would be to find the current desktop number along with the total number of desktops
# and then go right to the newest, but I'm not sure how to find the current desktop number, only the total desktops.
# You might look at 'defaults read com.apple.spaces' for the results in /ManagedSpaceID = / and see
# the pattern (I did too) but then it seems to change and the pattern for current desktop number goes away.
# This seems like an OK solution for now.
result=$(eval "defaults read com.apple.spaces | awk '/Current Space/{flag=1;next}/Collapsed Space/{flag=0}flag' | awk '/ManagedSpaceID = /' | sed -e 's/[^0-9]//g' | wc -l | xargs")
desktops=($result - 1)
for i in `seq 1 $desktops`;
do
  if [ $i == $desktops ]; then
     osascript -e 'tell application "System Events" to key code 124 using control down' \
               -e 'delay 0.5'
  else
    osascript -e 'tell application "System Events" to key code 124 using control down'
  fi
done

# Open some default applications
open -a Terminal "`pwd`"
open -na "Google Chrome"
/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -n --background -a ~/Documents/