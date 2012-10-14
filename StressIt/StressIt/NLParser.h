//
//  NLParser.h
//  StressIt
//
//  Created by Nikita Popov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLParser : NSObject<NSStreamDelegate>

+ (void) parse;
- (void) parse;
- (void) allNewParse;
@end
