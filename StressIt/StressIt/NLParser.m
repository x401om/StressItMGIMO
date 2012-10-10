//
//  NLParser.m
//  StressIt
//
//  Created by Nikita Popov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLParser.h"
#import "NLWord.h"

@implementation NLParser

+ (void)parse {
  NSString *path;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = paths[0];
  path = [path stringByAppendingPathComponent:@"All_Forms.txt"];  
  if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"All_Forms" ofType:@"txt"];
		[[NSFileManager defaultManager] copyItemAtPath:resourcePath toPath:path error:nil];
  }
  NSError* error;
  NSDate* tempDate = [NSDate date];
  NSMutableArray* tempArray = [NSMutableArray array]; //= [[NSMutableArray alloc] initWithContentsOfFile:path];
  NSString* file = [NSString stringWithContentsOfFile:path encoding:NSWindowsCP1251StringEncoding error:&error];
  [file enumerateLinesUsingBlock:^(NSString *line, BOOL *stop){
    if ([line length]>0) {
      [tempArray addObject:line];
      if (tempArray.count%1000==0) {
        NSLog(@"%i", tempArray.count);
      }
    }
  }];
  NSLog(@"%f",[tempDate timeIntervalSinceNow]);
  tempDate;
}

@end
