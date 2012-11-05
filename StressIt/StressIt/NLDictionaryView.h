//
//  NLDictionaryView.h
//  StressIt
//
//  Created by Nikita Popov on 19.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLSpinner.h"

@interface NLDictionaryView : UIViewController<UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSMutableArray* arrayOfWords;
@property (nonatomic, retain) IBOutlet UITableView* tableViewLeft;
@property (nonatomic, retain) IBOutlet UITableView* tableViewRight;
@property NLSpinner* spin;
@property NSFetchedResultsController* fetchResultsController;

@end
