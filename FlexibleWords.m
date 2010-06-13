//
//  ,--. .           .   .       ,   .           .     
//  |    |         o |   |       | . |           |     
//  |-   | ,-. . , . |-. | ,-.   | ) ) ,-. ;-. ,-| ,-. 
//  |    | |-'  X  | | | | |-'   |/|/  | | |   | | `-. 
//  '    ' `-' ' ` ' `-' ' `-'   ' '   `-' '   `-' `-'
//  
//  Bastien Dejean
//  June 2010
//

#import "FlexibleWords.h"
#import "TextMate.h"
#import "JRSwizzle.h"
#import "objc/runtime.h"

@interface FlexibleWords (Private_FlexibleWords)
- (void)dealloc;
- (void)installMenuItem;
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
	[self updateWordCharactersDictionary];	
        
    [OakTextView jr_swizzleMethod:@selector(setCurrentMode:) withMethod:@selector(FW_setCurrentMode:) error:NULL];
    [OakWindow jr_swizzleMethod:@selector(becomeMainWindow) withMethod:@selector(FW_becomeMainWindow) error:NULL];
    
	[OakWordCharacters jr_swizzleMethod:@selector(isWordCharacter:) withMethod:@selector(FW_isWordCharacter:) error:NULL];
  
  }
  return self;  
}

- (void) updateWordCharactersDictionary
{
	NSString* plistPath = [@"~/.TM_WordCharacters.plist" stringByExpandingTildeInPath];
	wordCharactersDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];	
	[self updateWordCharacters];
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
	NSString* mode;
	object_getInstanceVariable([NSApp targetForAction:@selector(document)], "currentMode", (void**)&mode);
	[self updateWordCharactersWithMode:mode];		
}

- (void)updateWordCharactersWithMode:(NSString*)mode
{
	if (mode) {
		wordCharacters = [wordCharactersDictionary objectForKey:mode];

		if (wordCharacters) {
			// NSLog(@"---> WordCharacters: %@", wordCharacters);
			NSMutableCharacterSet *workingSet;
			workingSet = [[NSCharacterSet alphanumericCharacterSet] mutableCopy];
			[workingSet addCharactersInString:wordCharacters];
			finalCharSet = [workingSet copy];
			[workingSet release];
		}	
	}
}

- (void)dealloc
{
  [sharedInstance release];
  sharedInstance = nil;
  [super dealloc];
}

- (void)installMenuItem
{
	NSMenu* windowMenu;

	if (windowMenu = [[[[NSApp mainMenu] itemWithTitle:@"Bundles"] submenu] retain])
	{
		NSArray* items = [windowMenu itemArray];

		int index = 0;
		for (NSMenuItem* item in items)
		{
			if ([[item title] isEqualToString:@"Select Bundle Item…"])
			{
				index = [items indexOfObject:item]+1;
			} 
		}

		NSMenuItem* mi = [[NSMenuItem alloc] initWithTitle:@"Update FlexibleWords" action:@selector(updateWordCharactersDictionary) keyEquivalent:@"u"];
		[mi setKeyEquivalentModifierMask:NSControlKeyMask|NSCommandKeyMask];
		[mi setTarget:self];
		[windowMenu insertItem:mi atIndex:index];
	}
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
	;
}

- (id)autorelease
{
    return self;
}

@end