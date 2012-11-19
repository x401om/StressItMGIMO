//
//  NLLabel.m
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLLabel.h"

#define debugging 1

#define kFontName @"Cuprum-Regular"
#define kMaxFontSize 50
#define kVerticalOffset 180
#define kLabelHeight 50

// 80 177 205 - blue
// 66 79 91 - dark blue
// 169 47 72 - red

@implementation NLLabel

@synthesize stresssed = _stresssed;
@synthesize vowelLetters = _vowelLetters;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithText:(NSString *)text andStressed:(NSInteger)stressed {
  CGSize windowSize = [[[UIApplication sharedApplication]delegate] window].frame.size;
  int width = windowSize.height;
  self = [[NLLabel alloc]initWithFrame:CGRectMake(0, kVerticalOffset, width, kLabelHeight)];
  self.stresssed = stressed;

  self.backgroundColor = [UIColor clearColor];
  
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
  [self vowelsInWord:text];
  self.userInteractionEnabled = YES;
  [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:66.f/255.f green:79.f/255.f blue:91.f/255.f alpha:1] range:NSMakeRange(0, attributedString.length)];
//  for (NSNumber *number in self.vowelLetters) {
//
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([number intValue], 1)];
//  }
  float fontSize = [self recommendedFontSizeForWord:text];
  
  // label initialization
  
  [self setFont:[UIFont fontWithName:kFontName size:fontSize]];
  [self setTextAlignment:NSTextAlignmentCenter];
  self.attributedText = attributedString;
  
  return self;
}


- (NSString *)characterAtIndex:(int)index inString:(NSString *)string {
  NSRange range;
  range.location = index;
  range.length = 1;
  return [string substringWithRange:range];
}

- (BOOL)point:(CGPoint)point inRect:(CGRect)rect {
  return (point.x >= rect.origin.x && point.x <= rect.origin.x + rect.size.width) &&  (point.y >= rect.origin.y && point.y <= rect.origin.y + rect.size.height);
}

- (int)touchedLetter:(CGPoint)touchLocation {
  NSString *word = self.text;
  float fontSize = self.font.pointSize;
  CGSize wordSize = [word sizeWithFont:[UIFont fontWithName:kFontName size:fontSize]];
  CGRect wordRect;
  wordRect.size = wordSize;
  wordRect.origin.y = self.frame.size.height/2 - wordRect.size.height/2;
  wordRect.origin.x = self.frame.origin.x + self.frame.size.width/2 - wordSize.width/2;
  NSMutableArray *letterRects = [NSMutableArray array];
  for (int i = 0; i < word.length; ++i) {
		NSRange range;
		range.location = i;
		range.length = 1;
    NSString *currentChar = [word substringWithRange:range];
		CGSize currentize = [currentChar sizeWithFont:[UIFont fontWithName:kFontName size:fontSize]];
    range.location = 0;
    range.length = i+1;
    CGSize bigSize = [[word substringWithRange:range] sizeWithFont:[UIFont fontWithName:kFontName size:fontSize]];
    CGRect rect;
    rect.size = currentize;
    rect.origin.y = wordRect.origin.y;
    rect.origin.x = wordRect.origin.x + bigSize.width - rect.size.width;
    
    [letterRects addObject:[NSValue valueWithCGRect:rect]];
	}
  
  for (int i = 0; i < letterRects.count; ++i) {
    NSValue *currentValue = [letterRects objectAtIndex:i];
    CGRect current = [currentValue CGRectValue];
    if ([self point:touchLocation inRect:current]) {
      return i;
    }
  }
  NSLog(@"Shit...");
  return -1;
}

- (float)recommendedFontSizeForWord:(NSString *)word {
  CGSize need = [word sizeWithFont:[UIFont fontWithName:kFontName size:kMaxFontSize]];
  CGSize here = self.frame.size;
  if(need.width < here.width) return kMaxFontSize;
  float fontSize = kMaxFontSize;
  while (true) {
    fontSize -= 0.5;
    need = [word sizeWithFont:[UIFont fontWithName:kFontName size:fontSize]];
    if(need.width < here.width) return fontSize;
  }
}

- (void)allLettersDefault {
  [UIView animateWithDuration:1 animations:^{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:66.f/255.f green:79.f/255.f blue:91.f/255.f alpha:1] range:NSMakeRange(0, attributedString.length)];
    self.attributedText = attributedString;
  }];
}

- (void)setColor:(UIColor *)color atIndex:(int)index {
  [UIView animateWithDuration:1 animations:^{
    self.alpha = 0;
  } completion:^(BOOL finished) {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString: self.attributedText];
    NSRange range;
    range.location = index;
    range.length = 1;
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = attributedString;
  }];
 [UIView animateWithDuration:1 animations:^{
   self.alpha = 1;
 }];

}

- (void)answeredWithLetter:(int)number {
  if ([self.delegate conformsToProtocol:@protocol(NLLabelDelegate)]) {
    [self.delegate performSelector:@selector(userTouchedOnLetter:) withObject:[NSNumber numberWithInt:number]];
  }
  NSString *word = self.text;
  if (![self isVovel:[self characterAtIndex:number inString:word]]) return;
  [self allLettersDefault];
  UIColor *newColor;
  if (number == self.stresssed)
  {
    newColor = [UIColor colorWithRed:80.f/255.f green:177.f/255.f blue:205.f/255.f alpha:1];
    if ([self.delegate respondsToSelector:@selector(userAnsweredWithAnswer:)]) {
      [self.delegate userAnsweredWithAnswer:YES];
    }
  } else {
    newColor = [UIColor colorWithRed:169.f/255.f green:47.f/255.f blue:72.f/255.f alpha:1];
    if ([self.delegate respondsToSelector:@selector(userAnsweredWithAnswer:)]) {
      [self.delegate userAnsweredWithAnswer:NO];
    }
  } 
  [self setColor:newColor atIndex:number];
}

- (BOOL)isVovel: (NSString*) letter {
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if (touch.view != self) return;
  CGPoint location = [touch locationInView:self];
  if (debugging) NSLog(@"%@", [NSValue valueWithCGPoint:location]);
  
  int letter = [self touchedLetter:location];
  [self answeredWithLetter:letter];
    
}

- (id)initWithWord:(NLCD_Word *)word
{
  self = [self initWithText:[word text] andStressed:[[word stressed] integerValue]];
  return self;
}

@end
