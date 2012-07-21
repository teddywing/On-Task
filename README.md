On Task
=======

On Task is a command line tool that aims to get you thinking about how you spend time on the computer. The idea is that if you get distracted from your work, this tool will remind you to stay on track, and try to keep you accountable using records.

The program is meant to be run at intervals using the included launchd plist file. By default it will run every 10 minutes.

When that happens, On Task will make a soft ~tink~ sound to remind you of its presence. It will then take a screenshot to preserve a visual record of your virtual transgressions. Finally, a log file is opened, allowing you to write down what you've been doing for the past ten minutes or so.


## Requirements

On Task was written and tested on Mac OS X 10.4.11. I have not tested it on any other OS. Later versions of Mac OS X may be able to run it, but I'm not sure yet.


## Installation

1. Build using Xcode and put the OnTask executable in `/usr/local/bin/`.
2. Put the `com.teddywing.OnTask.plist` file in your `~/Library/LaunchAgents/` directory
3. Fire up a Terminal and run `launchctl load ~/Library/LaunchAgents/com.teddywing.OnTask.plist`
4. Then run `launchctl start com.teddywing.OnTask`

The background process should then start and On Task will come up every so often. If you start getting annoyed, feel free to change the `StartInterval` value in the plist, which defines how often On Task should run. If you change the plist you'll need to reload it using `launchctl` using the instructions below.

To turn On Task off (stop it from running at intervals), then run the following:

    `launchctl stop com.teddywing.OnTask`

Additionally, you can run `launchctl unload ~/Library/LaunchAgents/com.teddywing.OnTask.plist` so that the program doesn't start again on your next login session.


## Uninstalling

1. If On Task is still running periodically, run `launchctl stop com.teddywing.OnTask`
2. Then run `launchctl unload ~/Library/LaunchAgents/com.teddywing.OnTask.plist` to remove it from your LaunchAgents list
3. Delete the `com.teddywing.OnTask.plist` file
4. Delete the OnTask executable


## File spam

On Task will create files. Those are:

- A single text file for the text-based log
- A timestamped screenshot image every time the program is run

That's it. Those all reside in the `~/Library/Application Support/On Task` directory.


## Thanks

* This idea is entirely [Jason Robb](http://jasonrobb.com/)'s. I take no credit for it, but I thought it was really cool, and something I wanted to do myself.
* Matt Gallagher wrote a nice Objective-C category to allow easy access to [an app's Application Support directory](http://cocoawithlove.com/2010/05/finding-or-creating-application-support.html).
* Since Matt's code was 10.5+ only, I accomplished something similar using [a method](http://www.cocoabuilder.com/archive/cocoa/190500-saving-to-application-support-folder.html#190506) from Hasani Hunter.


## License

On Task is licensed with the MIT License.
