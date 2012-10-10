//
//  NLLearningDictionary.m
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLLearningDictionary.h"
#import "NLWordBlock.h"


@implementation NLLearningDictionary

@dynamic blocks;

- (id)initWithBlocks:(NSArray *)blockSet {
  self.blocks = [NSSet setWithArray:blockSet];
  return self;
}


@end
