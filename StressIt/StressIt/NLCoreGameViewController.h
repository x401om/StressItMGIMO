//
//  NLCoreGameViewController.h
//  StressIt
//
//  Created by Alexey Goncharov on 05.11.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLLabel.h"
#import "NLSpinner.h"

@class NLCD_Paragraph;

typedef enum {
  NLGameTypeTwo
} NLGameType;

@interface NLCoreGameViewController : UIViewController <NLLabelDelegate> {
  NSManagedObjectContext *contextObject;
  NSArray *blocks; // nlblocks
  NSArray *currentBlockArray;
  NLCD_Paragraph *currentParagraph;
}

@property (nonatomic, strong) IBOutlet NLLabel* label;
@property (strong, nonatomic) IBOutlet UILabel *exampleLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightAnswers;
@property (strong, nonatomic) IBOutlet NLSpinner *progressRound;

//buttons
@property (strong, nonatomic) IBOutlet UIButton *favouriteButton;
@property (strong, nonatomic) IBOutlet UIView *soundButton;
@property (strong, nonatomic) IBOutlet UIButton *questionButton;

- (id)initWithWords:(NSArray *)words;
- (id)initWithType:(NLGameType)type andParagraph:(NLCD_Paragraph *)paragraph;

@end
