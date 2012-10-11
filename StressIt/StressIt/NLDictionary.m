//
//  NLDictionary.m
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#define kDefaultName @"default"
#define kLearningName @"learning"

#import "NLDictionary.h"
#import "NLWordBlock.h"
#import "NLAppDelegate.h"

@implementation NLDictionary

@dynamic blocks;
@dynamic name;

+ (NLDictionary *)dictionaryWithBlocks:(NSArray *)blockSet andType:(DictionaryType)type {
    NSManagedObjectContext *context = ((NLAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
  NLDictionary *newDictionary = nil;
  newDictionary = [NSEntityDescription insertNewObjectForEntityForName:@"Dictionary" inManagedObjectContext:context];
  newDictionary.name = type == 0 ? kDefaultName : kLearningName; 
  newDictionary.blocks = [NSSet setWithArray:blockSet];
  return newDictionary;
}

+ (NLDictionary *)findDictionaryWithType:(DictionaryType)type {
  NSManagedObjectContext *myContext = ((NLAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  request.entity = [NSEntityDescription entityForName:@"Dictionary" inManagedObjectContext:myContext];
  NSString *name = type == 0 ? kDefaultName : kLearningName;
  request.predicate = [NSPredicate predicateWithFormat:@"name = %@",name];
  NSError *error = nil;
  return [[myContext executeFetchRequest:request error:&error]lastObject];
}

@end
