#import <Cocoa/Cocoa.h>

@protocol TMPlugInController
- (float)version;
@end

@interface FlexibleWords : NSObject
{
    NSString* wordCharacters;
    NSCharacterSet* finalCharSet;
    NSMenu* windowMenu;
    NSMenuItem* updateFlexibleWordsMenuItem;  	  	
}
+ (FlexibleWords*)instance;
- (id)initWithPlugInController:(id <TMPlugInController>)aController;
- (NSString*)getWordCharacters;
- (NSCharacterSet*)getFinalCharSet;
- (void)updateWordCharacters;
@end