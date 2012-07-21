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
	NSDate *now = [NSDate date];
	NSString *date = [df stringFromDate:now];
	
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
	[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	date = [df stringFromDate:now];
	NSString *logPath = [applicationSupportPath stringByAppendingString:@"/On Task Log.txt"];
	
	NSFileHandle *log_f = [NSFileHandle fileHandleForUpdatingAtPath:logPath];
	if (log_f == nil) {
		[[NSFileManager defaultManager] createFileAtPath:logPath contents:nil attributes:nil];
		log_f = [NSFileHandle fileHandleForUpdatingAtPath:logPath];
	}
	else {
		[log_f seekToEndOfFile];
		[log_f writeData:[[NSString stringWithString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	}
	[log_f writeData:[[date stringByAppendingString:@": "] dataUsingEncoding:NSUTF8StringEncoding]]; // Write date stamp
	[log_f closeFile];
	
	[[NSWorkspace sharedWorkspace] openFile:logPath withApplication:@"TextEdit"];
	
	
	// Cleanup
	[df release];
	
    [pool release];
    return 0;
}
