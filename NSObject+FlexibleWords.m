#import "TextMate.h"
#import "FlexibleWords.h"
#import "NSObject+FlexibleWords.h"

@implementation NSObject (FW_NSObject)

- (BOOL)FW_isWordCharacter:(unsigned short)chr
{
  NSString* wordCharacters = [[FlexibleWords instance] getWordCharacters];  
  
  if (wordCharacters) {
    NSCharacterSet* finalCharSet = [[FlexibleWords instance] getFinalCharSet];
    return [finalCharSet characterIsMember:chr];
  } else {
    return [self FW_isWordCharacter:chr];
  }	
  
}

@end
