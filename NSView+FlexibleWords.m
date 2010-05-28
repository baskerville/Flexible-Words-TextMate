#import "TextMate.h"
#import "FlexibleWords.h"
#import "NSView+FlexibleWords.h"

@implementation NSView (FW_NSView)

- (void)FW_setCurrentMode:(id)mode
{
    [self FW_setCurrentMode:mode];
    [[FlexibleWords instance] updateWordCharacters];    
}

- (void)FW_preferencesDidChange:(id)sender
{
    [self FW_preferencesDidChange:sender];
    [[FlexibleWords instance] updateWordCharacters];        
}

@end
