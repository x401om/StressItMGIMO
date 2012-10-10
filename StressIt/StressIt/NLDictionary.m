//
//  NLDictionary.m
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLDictionary.h"
#import "NLWordBlock.h"


@implementation NLDictionary

@dynamic blocks;

+ (NLDictionary *)dictionaryWithBlocks:(NSArray *)blockSet inManagedObjectContext:(NSManagedObjectContext *)context {
  NLDictionary *newDictionary = nil;
  newDictionary = [NSEntityDescription insertNewObjectForEntityForName:@"Dictionary" inManagedObjectContext:context];
  newDictionary.blocks = [NSSet setWithArray:blockSet];
  return newDictionary;
}


@end
