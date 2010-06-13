#import <Cocoa/Cocoa.h>

@protocol TMPlugInController
- (float)version;
@end

@interface FlexibleWords : NSObject
{
    NSString* wordCharacters;
    NSCharacterSet* finalCharSet;
	NSDictionary* wordCharactersDictionary;
}

+ (FlexibleWords*)instance;
- (id)initWithPlugInController:(id <TMPlugInController>)aController;
- (void) updateWordCharactersDictionary;
- (NSString*)getWordCharacters;
- (NSCharacterSet*)getFinalCharSet;
- (void)updateWordCharacters;
- (void)updateWordCharactersWithMode:(NSString*)mode;
@end