//
//  NLWelcomViewController.m
//  StressIt
//
//  Created by Alexey Goncharov on 04.11.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLWelcomeViewController.h"
#import "NLLearningManager.h"
#import "NLCoreGameViewController.h"
#import "NLDictionary.h"
#import "Generator.h"

#define kCuprumFontName @"Cuprum-Regular"


@interface NLWelcomeViewController ()

@end

@implementation NLWelcomeViewController

@synthesize numberOfDay, countOfTodaysWords, countOfMistakeWork, countOfTestWords;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define kCountOfBlocks 3

- (void)viewDidLoad
{
  [super viewDidLoad];
  numberOfDay.text = @"1";
  //todaysWords = [NLLearningManager newWordsForToday];
  NLDictionary *dict = [NLDictionary findDictionaryWithType:DictionaryTypeLearning];
  NSMutableArray *blocksToday = [NSMutableArray array];

  NSArray *blocks = [dict.blocks allObjects];
  for (int i = 0; i < kCountOfBlocks; ++i) {
    int a = [Generator generateNewNumberWithStart:0 Finish:blocks.count];
    [blocksToday addObject:blocks[a]];
  }
  blocks = nil;
  todaysWords = blocksToday;
  countOfTodaysWords.text = [NSString stringWithFormat:@"%d", todaysWords.count];
  countOfMistakeWork.text = @"0";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextButtonPressed:(id)sender {
  [self.navigationController pushViewController:[[NLCoreGameViewController alloc]initWithWords:todaysWords] animated:YES];
}
- (IBAction)backButtonPressed:(id)sender {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
