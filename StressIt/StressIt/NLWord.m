//
//  NLWord.m
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLWord.h"


@implementation NLWord

@dynamic text;
@dynamic stressed;
@dynamic condition;
@dynamic block;

+ (id)wordWithText:(NSString *)text andStressed:(int)stressedVowel inManagedObjectContext:(NSManagedObjectContext *)context {
  NLWord *newWord = nil;
  newWord = [NSEntityDescription insertNewObjectForEntityForName:@"Word" inManagedObjectContext:context];
  newWord.text = text;
  newWord.stressed = [NSNumber numberWithInt:stressedVowel];
  newWord.condition = [NSNumber numberWithInt:0];
  return newWord;
}

- (NSString *)description {
  int stressedPosition = [self.stressed intValue] + 1;
  NSString *output = [NSString stringWithFormat:@"%@'%@", [self.text substringToIndex:stressedPosition], [self.text substringFromIndex:stressedPosition]];
  return output;
}

@end
