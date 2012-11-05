//
//  NLWelcomViewController.h
//  StressIt
//
//  Created by Alexey Goncharov on 04.11.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLWelcomeViewController : UIViewController {
  NSArray *todaysWords;
}
@property (strong, nonatomic) IBOutlet UILabel *numberOfDay;
@property (strong, nonatomic) IBOutlet UILabel *countOfTodaysWords;
@property (strong, nonatomic) IBOutlet UILabel *countOfMistakeWork;
@property (strong, nonatomic) IBOutlet UILabel *countOfTestWords;

- (IBAction)nextButtonPressed:(id)sender;

@end
