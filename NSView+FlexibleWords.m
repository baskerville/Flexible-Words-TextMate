#import "TextMate.h"
#import "FlexibleWords.h"
#import "NSView+FlexibleWords.h"

@implementation NSView (FW_NSView)

- (void)FW_setCurrentMode:(id)mode
{
	[self FW_setCurrentMode:mode];
	// NSLog(@"--> FW_setCurrentMode: %@", mode);

	[[FlexibleWords instance] updateWordCharactersWithMode:mode];    
}

@end
