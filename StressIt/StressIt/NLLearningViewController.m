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

@interface NLLearningViewController ()

@end

@implementation NLLearningViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];

  [[UIApplication sharedApplication]setStatusBarHidden:YES];
  NLLabel *label = [[NLLabel alloc]initWithText:@"бёрд" andStressed:1];

  contextObject = ((NLAppDelegate *)[[UIApplication sharedApplication]delegate]).managedObjectContext;
  
  NSArray *words = @[@"совокупность",@"совокупности",@"совокупностью",@"совокупностить"];
  NSMutableArray *arr= [NSMutableArray array];
  for(NSString *text in words) {
    NLWord *newWord = [NLWord wordWithText:text andStressed:5 inManagedObjectContext:contextObject];
    [arr addObject:newWord];
  }
  NLWordBlock *block = [NLWordBlock blockWithWords:arr inManagedObjectContext:contextObject];

  //NSLog(block.description);
  
  
  
  
  
  [self.view addSubview:label];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  request.entity = [NSEntityDescription entityForName:@"WordBlock" inManagedObjectContext:contextObject];
 // request.predicate = [NSPredicate predicateWithFormat:@"listID > 0"];
  NSError *error = nil;
  NSArray *arr = [contextObject executeFetchRequest:request error:&error];
  //[NLParser parse];

  NLWordBlock *newBlock = arr[0];
  NLWord *word = [newBlock getRandomWord];
  [word deleteFromDatabase];
 // [newBlock deleteWordWithText:@"совокупность"];
  
  return;
}

@end
