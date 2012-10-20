//
//  NLLearningViewController.m
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLLearningViewController.h"
#import "NLLabel.h"
#import "NLDictionary.h"
#import "NLAppDelegate.h"
#import "NLWord.h"
#import "NLWordBlock.h"
#import "NLParser.h"
#import "Generator.h"

#define wordCount 2555779

@interface NLLearningViewController ()

@end

@implementation NLLearningViewController
@synthesize label;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)addDatabase {
  
}

- (NLLabel *)getRandomWord {
  NLDictionary *learning = [NLDictionary findDictionaryWithType:DictionaryTypeLearning];
  NSArray *wordsArray = [learning.blocks allObjects];
  NLWordBlock *newBlock = [wordsArray objectAtIndex:[Generator generateNewNumberWithStart:0 Finish:wordsArray.count]];
  NSArray *words = [newBlock wordsArray];
  return  [[NLLabel alloc] initWithWord:[words objectAtIndex:[Generator generateNewNumberWithStart:0 Finish:words.count]]];
}

-(void)newWord
{
  [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    [label setAlpha:0];
  } completion:^(BOOL fin){
    [label removeFromSuperview];
    label = [self getRandomWord];
    [label setAlpha:0];
    [self.view addSubview:label];
    [UIView animateWithDuration:0.5 animations:^{
      [label setAlpha:1];
    }];
  }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  contextObject = ((NLAppDelegate *)[[UIApplication sharedApplication]delegate]).managedObjectContext;
  [[UIApplication sharedApplication]setStatusBarHidden:YES];
  
  
  NSArray *words = @[@"совокупность",@"совокупности",@"совокупностью",@"совокупностить"];
  NSMutableArray *arr= [NSMutableArray array];
  for(NSString *text in words) {
    NLWord *newWord = [NLWord wordWithText:text andStressed:5];
    [arr addObject:newWord];
  }
  //NLWordBlock *block = [NLWordBlock blockWithWords:arr];

  //NSLog(block.description);
  
  
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newWord) name:@"trueAnswer" object:nil];
  
  [self newWord];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//  NSFetchRequest *request = [[NSFetchRequest alloc] init];
//  request.entity = [NSEntityDescription entityForName:@"WordBlock" inManagedObjectContext:contextObject];
// // request.predicate = [NSPredicate predicateWithFormat:@"listID > 0"];
//  NSError *error = nil;
//  NSArray *arr = [contextObject executeFetchRequest:request error:&error];
//  //[NLParser parse];
//
//  NLWordBlock *newBlock = arr[0];
//  NLWord *word = [newBlock getRandomWord];
//  [newBlock deleteWordWithText:word.text];
// // [newBlock deleteWordWithText:@"совокупность"];
  
  return;
}

-(IBAction)goToMainMenu:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}

@end
