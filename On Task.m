#import <AppKit/AppKit.h>

#import "NSFileManager+DirectoryLocations.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	// Get Application Support dir path
	NSString *applicationSupportPath = [[NSFileManager defaultManager] applicationSupportDirectory];
	
	// Get a date string
	[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMddHHmmss"];
	NSString *date = [df stringFromDate:[NSDate date]];
	
    // # Take screenshot
	// Make screenshots directory if needed
	NSString *screenshotsPath = [applicationSupportPath stringByAppendingString:@"/Screenshots"];
	if (![[NSFileManager defaultManager] fileExistsAtPath:screenshotsPath]) {
		if (![[NSFileManager defaultManager] createDirectoryAtPath:screenshotsPath attributes:nil]) {
			NSLog(@"Error: Could not create folder %@", screenshotsPath);
		}
	}
	
	NSTask *takeScreenshot = [[NSTask alloc] init];
	[takeScreenshot setLaunchPath:@"/usr/sbin/screencapture"];
	[takeScreenshot setArguments:[NSArray arrayWithObjects:@"-SxC", [applicationSupportPath stringByAppendingString:[NSString stringWithFormat:@"/Screenshots/%@.png", date]], nil]];
	[takeScreenshot launch];
	[takeScreenshot waitUntilExit];
	[takeScreenshot release];
	
	
	// # Play system beep
	NSSound *beep = [NSSound soundNamed:@"Tink"];
	[beep play];
	while ([beep isPlaying]) {
		// Don't exit the program before the sound finishes
	}
	
	
	// # Open text log
	
	[df release];
	
    [pool release];
    return 0;
}
