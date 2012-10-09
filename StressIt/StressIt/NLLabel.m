//
//  NLLabel.m
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLLabel.h"

@implementation NLLabel

@synthesize stresssed = _stresssed;
@synthesize vowelLetters = _vowelLetters;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(BOOL) isVovel: (NSString*) letter {
	NSArray* letters = [[NSArray alloc] initWithObjects:@"а", @"е", @"ё", @"и", @"о", @"у", @"ы",@"э",@"ю",@"я", @"А", @"Е",@"Ё", @"И", @"О", @"У", @"Ы", @"Э", @"Ю", @"Я",nil];
	for (int i = 0; i < letters.count; ++i) {
		if ([letter isEqualToString:[letters objectAtIndex:i]]) {
			return YES;
		}
	}
	return NO;
}

- (void)vowelsInWord:(NSString *)word {
  NSMutableArray *vowelsNumbers = [NSMutableArray array];
  for (int i = 0; i < word.length; ++i) {
		NSRange range;
		range.location = i;
		range.length = 1;
		if ([self isVovel: [word substringWithRange:range]]) {
			[vowelsNumbers addObject:[[NSNumber alloc] initWithInt:i]];
		}
	}
  self.vowelLetters = [NSArray arrayWithArray:vowelsNumbers];
}

- (id)initWithText:(NSString *)text andStressed:(NSInteger)stressed {
  self = [[NLLabel alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
  [self vowelsInWord:text];
  self.userInteractionEnabled = YES;
  for (NSNumber *number in self.vowelLetters) {
    NSRange range;
    range.location = [number intValue];
    range.length = 1;
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
  }
  self.attributedText = attributedString;
  
  return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if (touch.view != self) return;
  CGPoint location = [touch locationInView:self];
  
}

@end
