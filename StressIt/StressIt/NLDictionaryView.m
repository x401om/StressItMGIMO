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
    //[self initArrays];
    [self performSelectorInBackground:@selector(initArrays) withObject:nil];
  }
  return self;
}

-(void)initArrays
{
  arrayOfWords = [NSMutableArray array];
  for (int i=0; i<33; ++i) {
    NSManagedObjectContext *moc = [(NLAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                            entityForName:@"WordBlock" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
  
    // Set example predicate and sort orderings...
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                            @"title BEGINSWITH %@",[self getKeyFromNumber:i]];
    [request setPredicate:predicate];
  
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                      initWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    [request setSortDescriptors:@[sortDescriptor]];
  
    NSError *error;
    [arrayOfWords addObject:[moc executeFetchRequest:request error:&error]];
    if (arrayOfWords == nil)
    {
      // Deal with error...
    }
    [self.tableViewLeft reloadData];
    [self.tableViewRight reloadData];

  }
  
}

-(NSString*)getKeyFromNumber:(NSInteger)number
{
  switch (number) {
    case 0:
      return @"а";
      break;
    case 1:
      return @"б";
      break;
    case 2:
      return @"в";
      break;
    case 3:
      return @"г";
      break;
    case 4:
      return @"д";
      break;
    case 5:
      return @"е";
      break;
    case 6:
      return @"ё";
      break;
    case 7:
      return @"ж";
      break;
    case 8:
      return @"з";
      break;
    case 9:
      return @"и";
      break;
    case 10:
      return @"й";
      break;
    case 11:
      return @"к";
      break;
    case 12:
      return @"л";
      break;
    case 13:
      return @"м";
      break;
    case 14:
      return @"н";
      break;
    case 15:
      return @"о";
      break;
    case 16:
      return @"п";
      break;
    case 17:
      return @"р";
      break;
    case 18:
      return @"с";
      break;
    case 19:
      return @"т";
      break;
    case 20:
      return @"у";
      break;
    case 21:
      return @"ф";
      break;
    case 22:
      return @"х";
      break;
    case 23:
      return @"ц";
      break;
    case 24:
      return @"ч";
      break;
    case 25:
      return @"ш";
      break;
    case 26:
      return @"щ";
      break;
    case 27:
      return @"ъ";
      break;
    case 28:
      return @"ы";
      break;
    case 29:
      return @"ь";
      break;
    case 30:
      return @"э";
      break;
    case 31:
      return @"ю";
      break;
    case 32:
      return @"я";
      break;
      
    default:
      return NULL;
      break;
  }
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
//#warning Potentially incomplete method implementation.
  // Return the number of sections.
  return [arrayOfWords count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
  // Return the number of rows in the section.
  return [[arrayOfWords objectAtIndex:section] count]/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  // Configure the cell...
  
  if(tableView.tag == 1000) cell.textLabel.text = [[[arrayOfWords objectAtIndex:indexPath.section] objectAtIndex:2*indexPath.row] title];
  if(tableView.tag == 1001) cell.textLabel.text = [[[arrayOfWords objectAtIndex:indexPath.section] objectAtIndex:2*indexPath.row + 1] title];

  
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

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  if(tableView == tableViewLeft) return [self getKeyFromNumber:section];
  else return @" ";
}

-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView {
  if (tableView == tableViewRight) {
    NSMutableArray* result = [NSMutableArray array];
    for (int i=0; i<[arrayOfWords count]; ++i) {
      [result addObject:[self getKeyFromNumber:i]];
    }
    return result;
  }
  else return NULL;
  
}



@end
