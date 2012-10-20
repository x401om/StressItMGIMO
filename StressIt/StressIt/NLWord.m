//
//  NLWord.m
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLWord.h"
#import "NLAppDelegate.h"

@implementation NLWord

@dynamic text;
@dynamic secondStressed;
@dynamic stressed;
@dynamic condition;
@dynamic block;
@dynamic example;
@dynamic info;

+ (id)wordWithText:(NSString *)text andStressed:(int)stressedVowel { 
  NSManagedObjectContext *context = ((NLAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
  NLWord *newWord = nil;
  newWord = [NSEntityDescription insertNewObjectForEntityForName:@"Word" inManagedObjectContext:context];
  newWord.text = text;
  newWord.secondStressed = [NSNumber numberWithInt:-1];
  newWord.stressed = [NSNumber numberWithInt:stressedVowel];
  newWord.condition = [NSNumber numberWithInt:0];
  //[newWord saveContext];
  return newWord;
}

- (NSString *)description {
  int stressedPosition = [self.stressed intValue] + 1;
  NSString *output = [NSString stringWithFormat:@"%@\u0301%@", [self.text substringToIndex:stressedPosition], [self.text substringFromIndex:stressedPosition]];
  return output;
}

- (void)saveContext {
  NSError *error = nil;
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}

+ (NLWord *)findWordWithText:(NSString *)text {
  NSManagedObjectContext *myContext = ((NLAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  request.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:myContext];
  request.predicate = [NSPredicate predicateWithFormat:@"text = %@",text];
  NSError *error = nil;
  return [[myContext executeFetchRequest:request error:&error]lastObject];
}


@end
