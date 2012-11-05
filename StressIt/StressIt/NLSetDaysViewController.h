//
//  NLSetDaysViewController.h
//  StressIt
//
//  Created by Alexey Goncharov on 04.11.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLSetDaysViewController : UIViewController {
  int n_allWords, n_wordPerDay;
}

@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *days;
@property (weak, nonatomic) IBOutlet UILabel *daysNaming;
@property (weak, nonatomic) IBOutlet UILabel *allWords;
@property (weak, nonatomic) IBOutlet UILabel *wordsPerDay;
@property (weak, nonatomic) IBOutlet UILabel *rank;

// uchangable elements
//@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
//@property (strong, nonatomic) IBOutlet UILabel *chooseTimeLbl;
//@property (strong, nonatomic) IBOutlet UILabel *allWordsLbl;
//@property (strong, nonatomic) IBOutlet UILabel *wordsPerDaysLbl;
//@property (strong, nonatomic) IBOutlet UILabel *difficultyLbl;
//@property (strong, nonatomic) IBOutlet UIButton *nextBtn;



- (IBAction)nextButtonPressed:(UIButton *)sender;

@end
