//
//  NLDictionary.h
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NLWordBlock;

@interface NLDictionary : NSManagedObject

@property (nonatomic, retain) NSSet *blocks;

+ (NLDictionary *)dictionaryWithBlocks:(NSArray *)blockSet inManagedObjectContext:(NSManagedObjectContext *)context;

@end

@interface NLDictionary (CoreDataGeneratedAccessors)

- (void)addBlocksObject:(NLWordBlock *)value;
- (void)removeBlocksObject:(NLWordBlock *)value;
- (void)addBlocks:(NSSet *)values;
- (void)removeBlocks:(NSSet *)values;

@end
