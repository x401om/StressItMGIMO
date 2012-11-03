//
//  NLLabel.h
//  StressIt
//
//  Created by Alexey Goncharov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "NLWord.h"

@protocol NLLabelDelegate <NSObject>

@optional

- (void)userTouchedOnLetter:(NSNumber *)letter;
@end

@interface NLLabel : UILabel<NLLabelDelegate>

@property int stresssed;
@property NSArray *vowelLetters;
@property id <NLLabelDelegate> delegate;

- (id)initWithText:(NSString *)text andStressed:(NSInteger)stressed;
- (id)initWithWord:(NLWord*)word;

@end

