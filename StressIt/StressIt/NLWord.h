//
//  NLWord.h
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NLWord : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * stressed;
@property (nonatomic, retain) NSNumber * condition;
@property (nonatomic, retain) NSManagedObject *block;

+ (NLWord *)wordWithText:(NSString *)text andStressed:(int)stressedVowel inManagedObjectContext:(NSManagedObjectContext *)context;



@end
