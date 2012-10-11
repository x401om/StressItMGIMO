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
#import "NLDictionary.h"

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
  NSMutableArray* tempDictionary = [NSMutableArray array];
  [file enumerateLinesUsingBlock:^(NSString *line, BOOL *stop){
    if ([line length]>0) {
      NSMutableArray* tempArray = (NSMutableArray*)[line componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#,"]];
      if ([tempArray[0] length]==1) {
        
      }
      else {
        NSMutableArray* arrayForBlock = [NSMutableArray array];
        for (int i=1;i<tempArray.count;++i) {
            NSMutableArray* stressedArray = [NSMutableArray arrayWithCapacity:2];
            if([tempArray[i] rangeOfString:@"`"].location!=NSNotFound) {
              [stressedArray addObject:[NSNumber numberWithInt:[tempArray[i] rangeOfString:@"`"].location - 1]];
              tempArray[i] = [tempArray[i] stringByReplacingOccurrencesOfString:@"`" withString:@""];
            }
            if ([tempArray[i] rangeOfString:@"'"].location!=NSNotFound) {
              [stressedArray addObject:[NSNumber numberWithInt:[tempArray[i] rangeOfString:@"'"].location - 1]];
              tempArray[i] = [tempArray[i] stringByReplacingOccurrencesOfString:@"'" withString:@""];
            }
          if ([stressedArray count]==0) {
            NSLog(@"%@ хуйня",tempArray[i]);
          }
          else {
            NLWord* word = [NLWord wordWithText:tempArray[i] andStressed:[stressedArray[0] intValue]];
            if([stressedArray count]==2) word.secondStressed = stressedArray[1];
            [arrayForBlock addObject:word];
          }
        }
        NLWordBlock* block;
        if([arrayForBlock count]!=0)
        {
          block = [NLWordBlock blockWithWords:arrayForBlock];
          [tempDictionary addObject:block];
        }
      }
    }
  }];
  NLDictionary* dictionary = [NLDictionary dictionaryWithBlocks:tempDictionary andType:DictionaryTypeDefault];
  NSLog(@"%f",[tempDate timeIntervalSinceNow]);
  
}

@end
