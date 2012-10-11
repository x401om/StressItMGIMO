//
//  NLDictionaryViewController.h
//  StressIt
//
//  Created by Nikita Popov on 10.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NLDictionaryViewController : UITableViewController <CLLocationManagerDelegate> {
  NSMutableArray *eventsArray;
  NSManagedObjectContext *managedObjectContext;
  
  CLLocationManager *locationManager;
  UIBarButtonItem *addButton;
}

@property (nonatomic, retain) NSMutableArray *eventsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) UIBarButtonItem *addButton;

@property (nonatomic, retain) NSMutableArray* arrayOfWords;


@end
