//
//  NLCD_Task.h
//  StressIt
//
//  Created by Alexey Goncharov on 12.11.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NLCD_Word;

@interface NLCD_Task : NSManagedObject

@property (nonatomic, retain) NSNumber * point;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * rule;
@property (nonatomic, retain) NSSet *words;
@property (nonatomic, retain) NSSet *exceptions;
@end

@interface NLCD_Task (CoreDataGeneratedAccessors)

- (void)addWordsObject:(NLCD_Word *)value;
- (void)removeWordsObject:(NLCD_Word *)value;
- (void)addWords:(NSSet *)values;
- (void)removeWords:(NSSet *)values;

- (void)addExceptionsObject:(NLCD_Word *)value;
- (void)removeExceptionsObject:(NLCD_Word *)value;
- (void)addExceptions:(NSSet *)values;
- (void)removeExceptions:(NSSet *)values;

@end
