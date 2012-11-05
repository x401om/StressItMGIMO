//
//  NLDictionaryView.m
//  StressIt
//
//  Created by Nikita Popov on 19.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLDictionaryView.h"
#import "NLAppDelegate.h"
#import "NLWordBlock.h"
#define letterCount 30

@interface NLDictionaryView ()

@end

@implementation NLDictionaryView
@synthesize arrayOfWords,tableViewLeft,tableViewRight;
@synthesize spin;
@synthesize fetchResultsController;

-(id)init
{
  self = [super init];
  if (self) {
    //[self initArrays];
    /*spin = [[NLSpinner alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50,self.view.frame.size.height/2 -20, 100, 100) type:NLSpinnerTypeDefault startValue:0];
    UIView* back = [[UIView alloc] initWithFrame:CGRectMake(42, 66, 507, 249)];
    back.backgroundColor = [UIColor blackColor];
    back.alpha = 0.5;
    back.tag = 1212;
    [self.view addSubview:back];
    [self.view addSubview:spin];
    [spin startSpin];
    tableViewLeft.userInteractionEnabled = NO;
    tableViewRight.userInteractionEnabled = NO;
    [self performSelectorInBackground:@selector(initArrays) withObject:nil];*/
    NSManagedObjectContext *managedObjectContext = [(NLAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"WordBlock" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    [request setSortDescriptors:@[sortDescriptor]];
    
    [request setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                        managedObjectContext:managedObjectContext sectionNameKeyPath:@"firstLetter"
                                                   cacheName:@"Root"];
    fetchResultsController = theFetchedResultsController;
    fetchResultsController.delegate = self;
    [fetchResultsController performFetch:nil];
    
  }
  return self;
}

-(void)initArrays
{
  arrayOfWords = [NSMutableArray array];
  //for (int i=0; i<letterCount; ++i) {
    NSManagedObjectContext *moc = [(NLAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                            entityForName:@"WordBlock" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
  
    // Set example predicate and sort orderings...
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:
      //                      @"title BEGINSWITH %@",[self getKeyFromNumber:i]];
    //[request setPredicate:predicate];
  
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
    //                                  initWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    //[request setSortDescriptors:@[sortDescriptor]];
  [request setFetchLimit:3000];
    NSError *error;
    NSArray* allObjects = [moc executeFetchRequest:request error:&error];
  for (int i = 0; i<letterCount; ++i) {
    [arrayOfWords addObject:[NSMutableArray array]];
  }
  
  for(NLWordBlock* temp in allObjects)
  {
   //NSLog(@"%i %@",(int)[temp.title characterAtIndex:0],temp.title);
    int pos = [self getNumberFromFirstLetter:temp.title];
    [[arrayOfWords objectAtIndex:pos] addObject:temp];
  }
  for (int i=0; i<letterCount; ++i) {
    [arrayOfWords replaceObjectAtIndex:i withObject:[[arrayOfWords objectAtIndex:i] sortedArrayUsingSelector:@selector(compare:)]] ;
  }

    if (arrayOfWords == nil)
    {
      // Deal with error...
    }
    //reloadData];
    [self.tableViewLeft performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];//reloadData];
    [self.tableViewRight performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
  //}
  tableViewRight.userInteractionEnabled = YES;
  tableViewLeft.userInteractionEnabled = YES;
  [UIView animateWithDuration:0.3 animations:^{
    [spin setAlpha:0];
    [[self.view viewWithTag:1212] setAlpha:0];
  } completion:^(BOOL finished) {
    [spin stopSpin];
    [spin removeFromSuperview];
    [[self.view viewWithTag:1212] removeFromSuperview];
  }];
  
  


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
    /*case 27:
      return @"ъ";
      break;
    case 28:
      return @"ы";
      break;
    case 29:
      return @"ь";
      break;*/
    case 27:
      return @"э";
      break;
    case 28:
      return @"ю";
      break;
    case 29:
      return @"я";
      break;
      
    default:
      return NULL;
      break;
  }
}

-(int)getNumberFromFirstLetter:(NSString*)str
{
  int result = [str characterAtIndex:0];
  if (result<=1077) {
    return result - 1072;
  }
  if (result>=1078&&result<=1097) {
    return result - 1071;
  }
  switch (result) {
    case 1105:
      return 6;
      break;
    case 1101:
      return 27;
      break;
    case 1102:
      return 28;
      break;
    case 1103:
      return 29;
      break;
    default:
      return 0;
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
  return [[fetchResultsController sections] count];//[arrayOfWords count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
  // Return the number of rows in the section.
  //return [[arrayOfWords objectAtIndex:section] count]/2;
  id  sectionInfo =
  [[fetchResultsController sections] objectAtIndex:section];
  return [sectionInfo numberOfObjects]/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  // Configure the cell...
  
  //NLWordBlock *info = [fetchResultsController objectAtIndexPath:indexPath];
  NSIndexPath* ind;
  
  if(tableView.tag == 1000) ind = [NSIndexPath indexPathForRow:(indexPath.row*2) inSection:indexPath.section];//cell.textLabel.text = [[[arrayOfWords objectAtIndex:indexPath.section] objectAtIndex:2*indexPath.row] title];
  if(tableView.tag == 1001) ind = [NSIndexPath indexPathForRow:(indexPath.row*2 + 1) inSection:indexPath.section];//cell.textLabel.text = [[[arrayOfWords objectAtIndex:indexPath.section] objectAtIndex:2*indexPath.row + 1] title];
    NLWordBlock *info = [fetchResultsController objectAtIndexPath:ind];
  cell.textLabel.text = info.title;
  
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
    NSMutableArray* ar = [NSMutableArray arrayWithCapacity:letterCount];
    for (int i=0; i<letterCount; ++i) {
      [ar addObject:[self getKeyFromNumber:i]];
    }
    return ar;//[fetchResultsController sectionIndexTitles];
  }
  else return nil;//[fetchResultsController sectionIndexTitles];
  
}




-(IBAction)goToMainMenu:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}




@end
