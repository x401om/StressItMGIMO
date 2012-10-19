//
//  NLDictionaryView.m
//  StressIt
//
//  Created by Nikita Popov on 19.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLDictionaryView.h"
#import "NLAppDelegate.h"

@interface NLDictionaryView ()

@end

@implementation NLDictionaryView
@synthesize arrayOfWords,tableViewLeft,tableViewRight;

-(id)init
{
  self = [super init];
  if (self) {
    NSManagedObjectContext *moc = [(NLAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"WordBlock" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"title BEGINSWITH %@",@"а"];
    //[request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                      initWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    arrayOfWords = [[moc executeFetchRequest:request error:&error] mutableCopy];
    if (arrayOfWords == nil)
    {
      // Deal with error...
    }
    
  }
  return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      tableViewLeft.tag = 1000;
  tableViewRight.tag = 1001;
  [tableViewLeft setShowsVerticalScrollIndicator:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
  // Return the number of rows in the section.
  return [arrayOfWords count]/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  // Configure the cell...
  
  if(tableView.tag == 1000) cell.textLabel.text = [[arrayOfWords objectAtIndex:2*indexPath.row] title];
  if(tableView.tag == 1001) cell.textLabel.text = [[arrayOfWords objectAtIndex:2*indexPath.row + 1] title];

  
  return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
  if (scrollView.tag==1000) {
    [(UIScrollView*)[[scrollView superview] viewWithTag:1001] setContentOffset:scrollView.contentOffset];

  }
  if (scrollView.tag==1001) {
    [(UIScrollView*)[[scrollView superview] viewWithTag:1000] setContentOffset:scrollView.contentOffset];
  }
}




@end
