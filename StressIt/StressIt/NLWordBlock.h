//
//  NLWordBlock.h
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NLWord;

@interface NLWordBlock : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *words;

+ (NLWordBlock *)blockWithWords:(NSArray *)words inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSArray *)allBlocksInManagedObjectContext:(NSManagedObjectContext *)context;
- (NSArray *)wordsArray;
- (NLWord *)getRandomWord;

@end


@interface NLWordBlock (CoreDataGeneratedAccessors)

- (void)addWordsObject:(NLWord *)value;
- (void)removeWordsObject:(NLWord *)value;
- (void)addWords:(NSSet *)values;
- (void)removeWords:(NSSet *)values;

@end
