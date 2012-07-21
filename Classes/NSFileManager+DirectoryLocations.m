#import "NSFileManager+DirectoryLocations.h"

@implementation NSFileManager (DirectoryLocations)

/**
    Returns the support folder for the application, used to store the Core Data
    store file.  This code uses a folder named _ApplicationName_ for
    the content, either in the NSApplicationSupportDirectory location or (if the
    former cannot be found), the system's temporary directory.
  */

- (NSString *)applicationSupportDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex: 0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"On Task"];
}

@end
