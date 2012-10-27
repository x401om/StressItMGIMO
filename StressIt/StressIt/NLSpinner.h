//
//  NLSpinner.h
//  StressIt
//
//  Created by Alexey Goncharov on 27.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  NLSpinnerTypeTimer = 0,
  NLSpinnerTypeProgress = 1,
  NLSpinnerTypeDefault = 2
} NLSpinnerType;

@interface NLSpinner : UIView


- (id)initWithFrame:(CGRect)frame type:(NLSpinnerType)type;
- (id)initWithFrame:(CGRect)frame type:(NLSpinnerType)type colors:(NSArray *)colors;

- (void)changeProgress:(float)progress withValueAtCenter:(int)value;
- (void)startSpin;
- (void)stopSpin;

+ (id)getStaticSpinnerWithProgress:(float)progress valueAtCenter:(int)value;
+ (id)getStaticSpinnerWithProgress:(float)progress valueAtCenter:(int)value colors:(NSArray *)colors;

@end
