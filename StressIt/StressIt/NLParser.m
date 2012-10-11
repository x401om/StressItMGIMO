//
//  NLParser.m
//  StressIt
//
//  Created by Nikita Popov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLParser.h"
#import "NLWord.h"
#import "NLWordBlock.h"

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
  NSString* file = [NSString stringWithContentsOfFile:path encoding:NSWindowsCP1251StringEncoding error:&error];
  [file enumerateLinesUsingBlock:^(NSString *line, BOOL *stop){
    if ([line length]>0) {
      NSMutableArray* tempArray = (NSMutableArray*)[line componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#,"]];
      if ([tempArray[0] length]==1) {
        
      }
      else {
        NSMutableArray* arrayForBlock = [NSMutableArray array];
        for (int i=1;i<tempArray.count;++i) {
          NSLog(tempArray[i]);
          int stressed = [tempArray[i] rangeOfString:@"'"].location - 1;
            tempArray[i] = [tempArray[i] stringByReplacingOccurrencesOfString:@"'" withString:@""];
            NLWord* word = [NLWord wordWithText:tempArray[i] andStressed:stressed];
            [arrayForBlock addObject:word];
        }
        NLWordBlock* block = [NLWordBlock blockWithWords:arrayForBlock];
      }
    }
  }];
  NSLog(@"%f",[tempDate timeIntervalSinceNow]);
  
}

@end
