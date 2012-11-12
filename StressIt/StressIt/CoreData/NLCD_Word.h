//
//  NLCD_Word.h
//  StressIt
//
//  Created by Alexey Goncharov on 12.11.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NLCD_Word : NSManagedObject

@property (nonatomic, retain) NSString * example;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSNumber * secondStressed;
@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) NSNumber * stressed;
@property (nonatomic, retain) NSString * text;

@end