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
          NLWord* word1 = [NLWord wordWithText:word andStressed:[stressedArray[0] intValue]];
          if([stressedArray count]==2)
          {
            word1.secondStressed = stressedArray[1];
          }
          [arrayForBlock addObject:word1];
          
        }
      }
      NLWordBlock* block;
      if([arrayForBlock count]!=0)
      {
        block = [NLWordBlock blockWithWords:arrayForBlock];
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
    NLWordBlock *newBlock = [NLWordBlock findBlockWithTitle:currentWord];
    if (newBlock.title) {
      //NSLog(@"found %@", newBlock.title);
      [blocksArray addObject:newBlock];
    }
  }
  NLDictionary *newDictionary = [NLDictionary dictionaryWithBlocks:blocksArray andType:DictionaryTypeLearning];
  return;
}


@end
