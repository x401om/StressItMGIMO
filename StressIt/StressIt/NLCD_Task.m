//
//  NLCD_Task.m
//  StressIt
//
//  Created by Alexey Goncharov on 12.11.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLCD_Task.h"
#import "NLCD_Word.h"
#import "NLAppDelegate.h"

@implementation NLCD_Task

@dynamic point;
@dynamic title;
@dynamic rule;
@dynamic words;
@dynamic exceptions;

- (NLCD_Task *)newTaskWithParameters:(NSDictionary *)parameters {
  NSManagedObjectContext *context = ((NLAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
  NLCD_Task *newTask = nil;
  newTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:context];
  //newTask.name = type == 0 ? kDefaultName : kLearningName;
 // newTask.blocks = [NSSet setWithArray:blockSet];
  //[NLCD_Dictionary saveContext];
  return newTask;
}

@end
