#import <Foundation/Foundation.h>

#import "NSFileManager+DirectoryLocations.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	// Get Application Support dir path
	NSString *supportPath = [[NSFileManager defaultManager] applicationSupportDirectory];
	
	// Get a date string
	[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMddHHmmss"];
	NSString *date = [df stringFromDate:[NSDate date]];
	
    // Take screenshot
	NSTask *takeScreenshot = [[NSTask alloc] init];
	[takeScreenshot setLaunchPath:@"/usr/sbin/screencapture"];
	[takeScreenshot setArguments:[NSArray arrayWithObjects:@"-SxC", [supportPath stringByAppendingString:[NSString stringWithFormat:@"/%@.png", date]], nil]];
	[takeScreenshot launch];
	[takeScreenshot release];
	
	[df release];
	
    [pool release];
    return 0;
}
