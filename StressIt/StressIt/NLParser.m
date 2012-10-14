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
//    NSString *path;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    path = paths[0];
//    path = [path stringByAppendingPathComponent:@"All_Forms.txt"];
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"All_Forms" ofType:@"txt"];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
//      
//      [[NSFileManager defaultManager] copyItemAtPath:resourcePath toPath:path error:nil];
//    }
    __block int count,bad;
    bad = 0;
    count = 0;
    NSError* error;
    NSDate* tempDate = [NSDate date];
   //@autoreleasepool {
     NSString* file = [NSString stringWithContentsOfFile:resourcePath encoding:NSWindowsCP1251StringEncoding error:&error];
     //NSArray* test = [file componentsSeparatedByString:@"\n"];
    [file enumerateLinesUsingBlock:^(NSString* line, BOOL* stop){ @autoreleasepool {
      NSMutableString* currentString = [line mutableCopy];
      currentString = [[currentString substringFromIndex:[currentString rangeOfString:@"#"].location+1] mutableCopy];
      NSRange range = [currentString rangeOfString:@","];
      NSMutableArray* arrayForBlock = [NSMutableArray array];
      while (range.length!=0) @autoreleasepool{
        NSString* word = [currentString substringToIndex:range.location];
        NSRange t = {0,range.location+1};
        [currentString replaceCharactersInRange:t withString:@""];
        //currentString = [currentString substringFromIndex:range.location+1];
        range = [currentString rangeOfString:@","];
        NSMutableArray* stressedArray = [NSMutableArray arrayWithCapacity:2];
        if([word rangeOfString:@"`"].location!=NSNotFound) {
          [stressedArray addObject:[NSNumber numberWithInt:[word rangeOfString:@"`"].location - 1]];
          word = [word stringByReplacingOccurrencesOfString:@"`" withString:@""];
        }
        if ([word rangeOfString:@"'"].location!=NSNotFound) {
          [stressedArray addObject:[NSNumber numberWithInt:[word rangeOfString:@"'"].location - 1]];
          word = [word stringByReplacingOccurrencesOfString:@"'" withString:@""];
        }
        if ([stressedArray count]==0) {
          //NSLog(@"%@ bad",word);
          ++bad;
        }
        else {
          NLWord* word1 = [NLWord wordWithText:word andStressed:[stressedArray[0] intValue]];
          if([stressedArray count]==2) word1.secondStressed = stressedArray[1];
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
    NSLog(@"%f",-[tempDate timeIntervalSinceNow]);
    NSLog(@"%d",bad);
  }
}

- (void) allNewParse {
  NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"All_Forms" ofType:@"txt"];
  FILE* file = fopen([resourcePath UTF8String], "r");
  
  //NSString* sdsds = [NSString stringWithContentsOfFile:resourcePath encoding:NSWindowsCP1251StringEncoding error:nil];
 
  char* buffer = NULL;
  buffer = malloc(sizeof(char)*512);  
  NSManagedObjectContext* context = [(NLAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
  int bad=0;
  int count = 0;
  if (NO) while (fgets(buffer, 512, file)!=NULL) {
    //NSString* line = [NSString stringWithCString:buffer encoding:NSWindowsCP1251StringEncoding];
    @autoreleasepool {
      
      NSString* line = [[NSString alloc] initWithBytesNoCopy:buffer length:512*sizeof(char) encoding:NSWindowsCP1251StringEncoding freeWhenDone:NO];
      line = [line stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
      NSMutableCharacterSet* set = [NSMutableCharacterSet characterSetWithCharactersInString:@"#,"];
    
      NSMutableArray* tempArray = [NSMutableArray arrayWithArray:[line  componentsSeparatedByCharactersInSet:set]];
    
      NSMutableArray* arrayForBlock = [NSMutableArray array];
      for (int i=1;i<tempArray.count;++i) {
        @autoreleasepool {
          NSMutableArray* stressedArray = [NSMutableArray array];
          /*if([tempArray[i] rangeOfString:@"`"].location!=NSNotFound) {
            [stressedArray addObject:[NSNumber numberWithInt:[tempArray[i] rangeOfString:@"`"].location - 1]];
            [tempArray replaceObjectAtIndex:i withObject:[tempArray[i] stringByReplacingOccurrencesOfString:@"`" withString:@""]];
            //tempArray[i] = [tempArray[i] stringByReplacingOccurrencesOfString:@"`" withString:@""];
          }
          if ([tempArray[i] rangeOfString:@"'"].location!=NSNotFound) {
            [stressedArray addObject:[NSNumber numberWithInt:[tempArray[i] rangeOfString:@"'"].location - 1]];
            [tempArray replaceObjectAtIndex:i withObject:[tempArray[i] stringByReplacingOccurrencesOfString:@"'" withString:@""]];
            //tempArray[i] = [tempArray[i] stringByReplacingOccurrencesOfString:@"'" withString:@""];
          }
          if ([stressedArray count]==0) {
            //NSLog(@"%@ хуйня",tempArray[i]);
            ++bad;
          }
          else {
            NLWord* word = [NLWord wordWithText:tempArray[i] andStressed:[stressedArray[0] intValue]];
            if([stressedArray count]==2) word.secondStressed = stressedArray[1];
            [arrayForBlock addObject:word];
          }*/
          NSArray* stress = [tempArray[i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"ё'`"]];
          int stressPos = 0;
          NSMutableString* resultString = [NSMutableString string];
          [resultString appendString:stress[0]];
          for (int j=1; j<[stress count]; ++j) {
            stressPos = [stress[j-1] length]-1;
            [stressedArray addObject:[NSNumber numberWithInt:stressPos]];
            NSString* temp = stress[j];
            if (![temp isEqualToString:@""]) {
              [resultString appendString:temp];
            }
          }
          NSLog(@"%@",resultString);
          NSLog(@"%@",tempArray[i]);
          if ([stressedArray count]==0) {
            //NSLog(@"%@ хуйня",tempArray[i]);
            ++bad;
          }
          else {
            NLWord* word = [NLWord wordWithText:resultString andStressed:[stressedArray[0] intValue]];
            if([stressedArray count]==2) word.secondStressed = stressedArray[1];
            if([stressedArray count]==3) NSLog(@"%@ 3 ударения в слове О_о",tempArray[i]);
            [arrayForBlock addObject:word];
          }
        }
      }
      NLWordBlock* block;
      if([arrayForBlock count]!=0)
      {
        block = [NLWordBlock blockWithWords:arrayForBlock];
        ++count;
        [arrayForBlock removeAllObjects];
      }
      if (count==1000) {
        [(NLAppDelegate*)[[UIApplication sharedApplication] delegate] saveContext];
        count=0;
      }
    }
  }
  NSLog(@"%d",bad);
  [(NLAppDelegate*)[[UIApplication sharedApplication] delegate] saveContext];
  fclose(file);
  free(buffer);
  
  
  
  //NSString* str = [NSString stringWithContentsOfFile:resourcePath encoding:NSWindowsCP1251StringEncoding error:nil];

  
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
  if (eventCode == NSStreamEventHasBytesAvailable) {
      NSMutableData* _data = [NSMutableData data];
    uint8_t buf[1024];
    unsigned int len = 0;
    len = [(NSInputStream *)stream read:buf maxLength:1024];
    if(len) {
      [_data appendBytes:(const void *)buf length:len];
      // bytesRead is an instance variable of type NSNumber.
      //[bytesRead setIntValue:[bytesRead intValue]+len];
    } else {
      NSLog(@"no buffer!");
    }
  }
}

- (void) parse {
  [NLParser parse];
}

@end
