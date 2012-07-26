#!/usr/bin/env bash

# OnTask toggle on/off
# 
# Created on 2012.07.25
# By Teddy Wing (http://teddywing.com)
# 
# Copyright (c) 2012 Teddy Wing
# 
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
# 

ON_TASK_PLIST_TEXT="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple Computer//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
	<key>Label</key>
	<string>com.teddywing.OnTask</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/local/bin/OnTask</string>
	</array>
	<key>StartInterval</key>
	<integer>600</integer>
</dict>
</plist>
"

if [ -a ~/Library/LaunchAgents/com.teddywing.OnTask.plist ]; then
  # if plist exists in user's LaunchAgents directory
  # then unload from launchd
  # and move plist to On Task Application Support
  launchctl stop com.teddywing.OnTask
  launchctl unload ~/Library/LaunchAgents/com.teddywing.OnTask.plist
  
  mv ~/Library/LaunchAgents/com.teddywing.OnTask.plist ~/Library/Application\ Support/On\ Task/
  
  echo "On Task DEACTIVATED"
elif [ -a ~/Library/Application\ Support/On\ Task/com.teddywing.OnTask.plist ]; then
  # otherwise, if we find the plist in the On Task Application Support directory
  # then move it to the user's LaunchAgents directory
  mv ~/Library/Application\ Support/On\ Task/com.teddywing.OnTask.plist ~/Library/LaunchAgents/
  
  # and load it into launchd
  launchctl load ~/Library/LaunchAgents/com.teddywing.OnTask.plist
  
  echo "On Task ACTIVATED"
else
  # if neither of those, create a new LaunchAgent plist file with default text
  echo "$ON_TASK_PLIST_TEXT" > ~/Library/LaunchAgents/com.teddywing.OnTask.plist
  
  # and load it into launchd
  launchctl load ~/Library/LaunchAgents/com.teddywing.OnTask.plist
  
  echo "On Task INSTALLED & ACTIVATED"
fi
