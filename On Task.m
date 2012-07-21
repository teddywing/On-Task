#import <Foundation/Foundation.h>

#import "NSFileManager+DirectoryLocations.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSString *supportPath = [[NSFileManager defaultManager] applicationSupportDirectory];
	
    // Take screenshot
	NSLog(@"%@", supportPath);
	
    [pool release];
    return 0;
}
