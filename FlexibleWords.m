//
//  ,--. .           .   .       ,   .           .     
//  |    |         o |   |       | . |           |     
//  |-   | ,-. . , . |-. | ,-.   | ) ) ,-. ;-. ,-| ,-. 
//  |    | |-'  X  | | | | |-'   |/|/  | | |   | | `-. 
//  '    ' `-' ' ` ' `-' ' `-'   ' '   `-' '   `-' `-'
//  
//  Bastien Dejean
//  May 2010
//

#import "FlexibleWords.h"
#import "TextMate.h"
#import "JRSwizzle.h"
#import "objc/runtime.h"

@interface FlexibleWords (Private_FlexibleWords)
- (void)installMenuItem;
- (void)dealloc;
@end

@implementation FlexibleWords

static FlexibleWords *sharedInstance = nil;

+ (FlexibleWords*)instance
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (id)initWithPlugInController:(id <TMPlugInController>)aController
{
  if (self = [super init]) {          
    
    [self installMenuItem];
        
    [OakTextView jr_swizzleMethod:@selector(setCurrentMode:) withMethod:@selector(FW_setCurrentMode:) error:NULL];
    [OakTextView jr_swizzleMethod:@selector(preferencesDidChange:) withMethod:@selector(FW_preferencesDidChange:) error:NULL];    
    [OakWordCharacters jr_swizzleMethod:@selector(isWordCharacter:) withMethod:@selector(FW_isWordCharacter:) error:NULL];
  
  }
  return self;  
}

- (void)installMenuItem
{
  if(windowMenu = [[[[NSApp mainMenu] itemWithTitle:@"Edit"] submenu] retain])
  {
    NSArray* items = [windowMenu itemArray];
    
    int index = 0;
    for (NSMenuItem* item in items)
    {
      if ([[item title] isEqualToString:@"Special Characters…"])
      {
        index = [items indexOfObject:item]+1;
      } 
    }
    updateFlexibleWordsMenuItem = [[NSMenuItem alloc] initWithTitle:@"Flexible Words" action:@selector(updateWordCharacters) keyEquivalent:@"u"];
    [updateFlexibleWordsMenuItem setKeyEquivalentModifierMask:NSControlKeyMask|NSCommandKeyMask];
    [updateFlexibleWordsMenuItem setTarget:self];
    [windowMenu insertItem:updateFlexibleWordsMenuItem atIndex:index];
  }
}

- (NSString*)getWordCharacters
{
  return wordCharacters;
}

- (NSCharacterSet*)getFinalCharSet
{
  return finalCharSet;
}

- (void)updateWordCharacters
{
  NSDictionary* envVars = [[NSApp targetForAction:@selector(allEnvironmentVariables)] allEnvironmentVariables];
  wordCharacters = [envVars objectForKey:@"TM_WORD_CHARACTERS"];
  
  if (wordCharacters) {
    NSLog(@"wordCharacters: %@", wordCharacters);
    NSMutableCharacterSet *workingSet;
    workingSet = [[NSCharacterSet alphanumericCharacterSet] mutableCopy];
    [workingSet addCharactersInString:wordCharacters];
    finalCharSet = [workingSet copy];
    [workingSet release];
  }    
}

- (void)dealloc
{
  [sharedInstance release];
  sharedInstance = nil;
  [super dealloc];
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return UINT_MAX;
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

@end