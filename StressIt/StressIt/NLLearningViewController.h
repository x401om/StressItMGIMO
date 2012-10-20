//
//  NLLearningViewController.h
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLLabel.h"

@interface NLLearningViewController : UIViewController {
  NSManagedObjectContext *contextObject;
}

@property (nonatomic, strong) NLLabel* label;

@end
