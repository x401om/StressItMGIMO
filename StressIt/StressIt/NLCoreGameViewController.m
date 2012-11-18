//
//  NLCoreGameViewController.m
//  StressIt
//
//  Created by Alexey Goncharov on 05.11.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLCoreGameViewController.h"
#import "NLLabel.h"
#import "NLAppDelegate.h"
#import "NLCD_Word.h"
#import "NLCD_Block.h"
#import "NLParser.h"
#import "Generator.h"
#import "NLLearningManager.h"
#import "NLResultsViewController.h"

static int allAnswers = 0;
static int allTrueAnswers = 0;
static int allQuestions = 0;

static int currentWord = 0;
static int currentBlock = 0;
static int answers = 0;

@implementation NLCoreGameViewController

@synthesize label, exampleLabel, rightAnswers, progressRound;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (id)initWithWords:(NSArray *)words {
  self = [super init];
  if (self) {
    allAnswers = 0;
    allTrueAnswers = 0;
    allQuestions = 0;
    
    currentWord = 0;
    currentBlock = 0;
    answers = 0;

    blocks = words;
    contextObject = ((NLAppDelegate *)[[UIApplication sharedApplication]delegate]).managedObjectContext;
   // [[UIApplication sharedApplication]setStatusBarHidden:YES];
  }
  return self;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  for (NLCD_Block *b in blocks) {
    allQuestions += b.words.count;
  }
  progressRound = [[NLSpinner alloc]initWithFrame:progressRound.frame type:NLSpinnerTypeProgress startValue:0];
  [self.view addSubview:progressRound];
  rightAnswers.text = [NSString stringWithFormat:@"%d / %d", answers, allQuestions];
  NLCD_Block *block = blocks[currentBlock];
  currentBlockArray = [block.words array];
  [self presentNewWord];
  
}

- (void)presentNewWord {
  [label removeFromSuperview];
  label = nil;
  if (currentWord >= currentBlockArray.count) {
    currentWord = 0;
    ++currentBlock;
    if (currentBlock >= blocks.count) {
      [self goToMainMenu:nil];
    }
    NLCD_Block *block = blocks[currentBlock];
    currentBlockArray = [block.words array];
  }
  NLCD_Word *newWord = currentBlockArray[currentWord];
  currentWord++;
  label = [[NLLabel alloc]initWithWord:newWord];
  label.delegate = self;
  if (newWord.example) exampleLabel.text = newWord.example;
  else exampleLabel.text = nil;
  
  [self.view addSubview:label];
}



#pragma mark Buttons Methods

- (IBAction)goToMainMenu:(id)sender {
  [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)addToFavouritePressed:(id)sender {
  NSLog(@"Add to favourits");
}
- (IBAction)playSoundPressed:(id)sender {
  NSLog(@"playing sound...");
}
- (IBAction)questionPressedPressed:(id)sender {
  NSLog(@"What do u want to do, mr. Bean?");
}

#pragma mark NLLabelDelagate Methods

- (void)userTouchedOnLetter:(NSNumber *)letter {
  NSLog(@"smb touched on %@'th letter", letter);
}

- (void)userAnsweredWithAnswer:(BOOL)answer {
  ++allAnswers;
  int border = [[[NSUserDefaults standardUserDefaults]objectForKey:@"DaysAmount"]integerValue];
  if (border > 20) {
    border = 20;
  }
  rightAnswers.text = [NSString stringWithFormat:@"%d / %d", allAnswers, allQuestions];
  if (answer)  ++allTrueAnswers;
  [progressRound changeProgress:(float)allTrueAnswers/allAnswers withValueAtCenter:allTrueAnswers];
  if (allAnswers == border) {
    [self.navigationController pushViewController:[[NLResultsViewController alloc]initWithRight:allTrueAnswers andMistakes:allAnswers- allTrueAnswers ] animated:YES];
     }
  [self performSelector:@selector(presentNewWord) withObject:nil afterDelay:1.0];
}

@end
