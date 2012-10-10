//
//  NLLearningDictionary.h
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NLWordBlock;

@interface NLLearningDictionary : NSManagedObject

@property (nonatomic, retain) NSSet *blocks;

- (id)initWithBlocks:(NSArray *)blockSet;

@end

@interface NLLearningDictionary (CoreDataGeneratedAccessors)

- (void)addBlocksObject:(NLWordBlock *)value;
- (void)removeBlocksObject:(NLWordBlock *)value;
- (void)addBlocks:(NSSet *)values;
- (void)removeBlocks:(NSSet *)values;

@end
