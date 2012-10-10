//
//  NLLabel.h
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLLabel : UILabel

@property int stresssed;
@property NSArray *vowelLetters;

- (id)initWithText:(NSString *)text andStressed:(NSInteger)stressed;

@end
