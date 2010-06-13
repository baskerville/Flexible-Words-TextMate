#import "TextMate.h"
#import "FlexibleWords.h"
#import "NSWindow+FlexibleWords.h"

@implementation NSWindow (FW_NSWindow)

- (void)FW_becomeMainWindow
{
    [self FW_becomeMainWindow];
	// NSLog(@"FW_becomeMainWindow");
	
	[[FlexibleWords instance] updateWordCharacters];
}

@end
