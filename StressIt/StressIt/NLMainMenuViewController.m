//
//  NLMainMenuViewController.m
//  StressIt
//
//  Created by Alexey Goncharov on 09.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLMainMenuViewController.h"
#import "NLLearningViewController.h"
#import "NLDictionaryView.h"


@interface NLMainMenuViewController ()

@end

@implementation NLMainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  [[UIApplication sharedApplication]setStatusBarHidden:YES];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)learningButtonPressed:(id)sender {
  UIViewController *vc = [[NLLearningViewController alloc]init];
  [self.navigationController pushViewController:vc animated:YES];
  [self.label setHighlighted:NO];
}

-(IBAction)dictionaryButtonPressed:(id)sender {
  NLDictionaryView* dict = [[NLDictionaryView alloc] init];
  [self.navigationController pushViewController:dict animated:YES];
}

-(IBAction)learningButtonTouched:(id)sender {
  [self.label setHighlightedTextColor:[UIColor whiteColor]];
  [self.label setHighlighted:YES];
}

-(IBAction)learningButtonTouchEnded:(id)sender
{
  [self.label setHighlighted:NO];
}


@end
