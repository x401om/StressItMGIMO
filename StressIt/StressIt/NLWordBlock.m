//
//  NLWordBlock.m
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLWordBlock.h"
#import "NLWord.h"


@implementation NLWordBlock

@dynamic title;
@dynamic words;

- (id)initWithWords:(NSArray *)words {
  self.words = [NSSet setWithArray:words];
  NLWord *titleWord = [words objectAtIndex:0];
  self.title = titleWord.text;
  return self;
}

+ (NLWordBlock *)blockWithWords:(NSArray *)words inManagedObjectContext:(NSManagedObjectContext *)context {
  NLWordBlock *newBlock = nil;
  newBlock = [NSEntityDescription insertNewObjectForEntityForName:@"WordBlock" inManagedObjectContext:context];
  newBlock.words = [NSSet setWithArray:words];
  NLWord *titleWord = [words objectAtIndex:0];
  newBlock.title = titleWord.text;
  return newBlock;
}

+ (NSArray *)allBlocksInManagedObjectContext:(NSManagedObjectContext *)context {
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  request.entity = [NSEntityDescription entityForName:@"WordBlock" inManagedObjectContext:context];
  request.predicate = [NSPredicate predicateWithFormat:@"words.count > 0"];
  NSError *error = nil;
  return [context executeFetchRequest:request error:&error];
}

- (NSArray *)wordsArray {
  return [self.words allObjects];
}

- (NLWord *)getRandomWord {
  return [self.words anyObject];
}

- (void)addWordsObject:(NLWord *)value {
  NSMutableArray *allObjects = [[self.words allObjects]mutableCopy];
  [allObjects addObject:value];
  self.words = [NSSet setWithArray:allObjects];
  NSLog(@"Added %@", value);
}

- (void)removeWordsObject:(NLWord *)value {
  NSOrderedSet *set = [NSOrderedSet orderedSetWithSet:self.words];
  NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:set];
  [tempSet removeObject:value];
  self.words = [NSSet setWithArray:[tempSet array]] ;
  NSLog(@"Removed %@", value);
}

- (NSString *)description {
  NSString *output = self.title;
  output = [output stringByAppendingString:@"\n"];
  for (NLWordBlock *desc in self.words) {
    output = [output stringByAppendingString:desc.description];
    output = [output stringByAppendingString:@"\n"];
  }
  return output;
}

@end
