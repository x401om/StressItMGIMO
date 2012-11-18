//
//  NLParser.m
//  StressIt
//
//  Created by Nikita Popov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLParser.h"
#import "NLCD_Word.h"
#import "NLCD_Block.h"
#import "NLCD_Dictionary.h"
#import "NLAppDelegate.h"

@implementation NLParser

+ (void)parse {
  @autoreleasepool {
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"All_Forms" ofType:@"txt"];
    __block int count,bad;
    bad = 0;
    count = 0;
    NSError* error;
    NSDate* tempDate = [NSDate date];
     NSString* file = [NSString stringWithContentsOfFile:resourcePath encoding:NSWindowsCP1251StringEncoding error:&error];
    [file enumerateLinesUsingBlock:^(NSString* line, BOOL* stop){ @autoreleasepool {
      NSMutableString* currentString = [line mutableCopy];
      currentString = [[currentString substringFromIndex:[currentString rangeOfString:@"#"].location+1] mutableCopy];
      NSRange range = [currentString rangeOfString:@","];
      NSMutableArray* arrayForBlock = [NSMutableArray array];
      while (range.length!=0) @autoreleasepool{
        NSString* word = [currentString substringToIndex:range.location];
        NSRange t = {0,range.location+1};
        [currentString replaceCharactersInRange:t withString:@""];
        range = [currentString rangeOfString:@","];
        NSMutableArray* stressedArray = [NSMutableArray arrayWithCapacity:2];
        NSRange stressRange = [word rangeOfString:@"'"];
        while (stressRange.location!=NSNotFound) {
          [stressedArray addObject:[NSNumber numberWithInt:stressRange.location - 1]];
          word = [word stringByReplacingCharactersInRange:stressRange withString:@""];
          stressRange = [word rangeOfString:@"'"];
        }
        
        if ([stressedArray count]==0) {
          NSLog(@"%@ bad",word);
          ++bad;
        }
        else {
          NLCD_Word* word1 = [NLCD_Word wordWithText:word andStressed:[stressedArray[0] intValue]];
#warning new state
           //word1.state = [NSNumber numberWithInt:NLWordStateNew];
            
          if([stressedArray count]==2)
          {
            word1.secondStressed = stressedArray[1];
          }
          [arrayForBlock addObject:word1];
          
        }
      }
      NLCD_Block* block;
      if([arrayForBlock count]!=0)
      {
        block = [NLCD_Block blockWithWords:arrayForBlock];
        ++count;
        
      }
      if (count==1000) {
        [(NLAppDelegate*)[[UIApplication sharedApplication] delegate] saveContext];
        [[(NLAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext] reset];
        count = 0;
        //*stop = YES;
      }
    }}];

    [(NLAppDelegate*)[[UIApplication sharedApplication] delegate] saveContext];
    [[(NLAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext] reset];
    [NLParser fillFavourites];
    NSLog(@"%f",-[tempDate timeIntervalSinceNow]);
    NSLog(@"%d",bad);
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:@"ParceDone" object:nil];

}


- (void) parse {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"ParceStart" object:nil];
  [NLParser parse];
}

+ (void)fillFavourites {
  NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"dataArr" ofType:@"plist"];
  NSArray *data = [NSArray arrayWithContentsOfFile:resourcePath];
  NSMutableArray *blocksArray = [NSMutableArray array];
  for (NSString *currentWord in data) {
    NLCD_Block *newBlock = [NLCD_Block findBlockWithTitle:currentWord];
    if (newBlock.title) {
      //NSLog(@"found %@", newBlock.title);
      [blocksArray addObject:newBlock];
    }
  }
  [NLCD_Dictionary dictionaryWithBlocks:blocksArray andType:DictionaryTypeLearning];
  return;
}

+ (void)addTasks {
  NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"Tasks" ofType:@"plist"];
  NSArray *data = [NSArray arrayWithContentsOfFile:resourcePath];
  for (NSDictionary *currentParagraph in data) {
    NSString *parTitle = currentParagraph[@"Title"];
    NSString *parDeclar = currentParagraph[@"Declaration"];
    NSArray *tasks = currentParagraph[@"Tasks"];
    for (NSDictionary *currentTask in tasks) {
      NSString *tTitle = currentTask[@"Title"];
      NSString *tRule = currentTask[@"Rule"];
      NSArray *tWords = currentTask[@"Words"];
      for (NSString *str in tWords) {
        NSRange range = [str rangeOfString:@"—"];
        if (range.location == NSNotFound) continue;
        NSArray *arr = [str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"— (){}"]];
        NSString *example = arr[4];
        NSString *word = arr[6];
        NSString *mistake = arr[8];
        
      }
      NSArray *tExceptions = currentTask[@"Exceptions"];
    
    }
  }
}


@end
