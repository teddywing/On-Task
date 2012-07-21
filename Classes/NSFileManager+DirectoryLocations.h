// Based off of Matt Gallagher's 10.5+ category from:
//   http://cocoawithlove.com/2010/05/finding-or-creating-application-support.html
//
// Actual function code taken from Hasani Hunter:
//   http://www.cocoabuilder.com/archive/cocoa/190500-saving-to-application-support-folder.html#190506

#import <Foundation/Foundation.h>

//
// DirectoryLocations is a set of global methods for finding the fixed location
// directories.
//
@interface NSFileManager (DirectoryLocations)

- (NSString *)applicationSupportDirectory;

@end
