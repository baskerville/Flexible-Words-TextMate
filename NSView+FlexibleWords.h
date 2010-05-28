#import <Cocoa/Cocoa.h>

@interface  NSView (FW_NSView)
- (void)FW_setCurrentMode:(id)mode;
- (void)FW_preferencesDidChange:(id)sender;
@end