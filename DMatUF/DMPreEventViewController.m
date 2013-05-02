/*Dance Marathon Captain Application
 Copyright 2013 Dance Marathon at the University of Florida
 
 This product includes software developed by the Dance Marathon at the University of Florida 2013 Technology Team.
 The following developers contributed to this project:
 Matthew Gerstman
 
 Dance Marathon at the University of Florida is a year-long effort that culminates in a 26.2-hour event where over 800 students stay awake and on their feet to symbolize the obstacles faced by children with serious illnesses or injuries. The event raises money for Shands Hospital for Children, your local Children’s Miracle Network Hospital, in Gainesville, FL. Our contributions are used where they are needed the most, including, but not limited to, purchasing life-saving medial equipment, funding pediatric research, and purchasing diversionary activities for the kids.
 
 For more information you can visit http://floridadm.org
 
 This software includes the following open source plugins listed below:
 CalendarUI - Matias Muhonen
 Reachibility - Apple Inc
 Google Analytics - Google Inc
 
 */

#import "DMPreEventViewController.h"

@interface DMPreEventViewController ()

@end

@implementation DMPreEventViewController

@synthesize checkedIndexPath;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    itemsLoaded = NO;
    [super viewDidLoad];
    checkBox = [UIImage imageNamed:@"checkbox.png"];
    checkedBox = [UIImage imageNamed:@"checkedbox.png"];
    checkList = [[NSMutableArray alloc] init];
    
    
    
    sortedKeys = [[NSMutableArray alloc] init];
    listOfItems = [self allEvents];
    [sortedKeys sortUsingSelector:@selector(localizedCaseInsensitiveCompare:) ];

    for (NSString *key in sortedKeys)
    {
        int sectionCount = [[listOfItems objectForKey:key] count];
        NSMutableArray *section = [[NSMutableArray alloc] init];
        for (int i=0; i<sectionCount; i++)
        {
            [section addObject:[NSNumber numberWithBool:NO]];
        }
        
        [checkList addObject:section];
    }
    
    
    
    
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadItems) name:kReachabilityChangedNotification object:nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) loadItems
{
    if (itemsLoaded == NO)
    {
        checkList = [[NSMutableArray alloc] init];
        
        sortedKeys = [[NSMutableArray alloc] init];
        listOfItems = [self allEvents];
        [sortedKeys sortUsingSelector:@selector(localizedCaseInsensitiveCompare:) ];
        
        for (NSString *key in sortedKeys)
        {
            int sectionCount = [[listOfItems objectForKey:key] count];
            NSMutableArray *section = [[NSMutableArray alloc] init];
            for (int i=0; i<sectionCount; i++)
            {
                [section addObject:[NSNumber numberWithBool:NO]];
            }
            
            [checkList addObject:section];
        }

        [self.tableView reloadData];
    }
}

- (BOOL) connectedToNetwork
{
	Reachability *r = [Reachability reachabilityForInternetConnection];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	BOOL internet;
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
		internet = NO;
	} else {
		internet = YES;
	}
	return internet;
}

-(BOOL) checkInternet
{
	//Make sure we have internet connectivity
	if([self connectedToNetwork] != YES)
	{
		return NO;
	}
	else {
		return YES;
	}
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
    return [sortedKeys count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [sortedKeys objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *listData =[listOfItems objectForKey:[sortedKeys objectAtIndex:section]];
    return [listData count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *array = [listOfItems objectForKey:[sortedKeys objectAtIndex:indexPath.section]];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    
    if ([[NSNumber numberWithInt:1] isEqualToNumber:[[checkList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]])
    {
        cell.accessoryView = [[UIImageView alloc] initWithImage:checkedBox];
    }
    else
    {
        cell.accessoryView = [[UIImageView alloc] initWithImage:checkBox];
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryView = [[UIImageView alloc] initWithImage:checkedBox];
//    NSLog(@"%d %d %@", indexPath.section, indexPath.row, [[checkList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
    
    if ([[NSNumber numberWithInt:1] isEqualToNumber:[[checkList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]])
    {

        [[checkList objectAtIndex:indexPath.section] replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
        selectedCell.accessoryView = [[UIImageView alloc] initWithImage:checkBox];
    }
    else
    {

       [[checkList objectAtIndex:indexPath.section] replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
        selectedCell.accessoryView = [[UIImageView alloc] initWithImage:checkedBox];
    }

}

//Commented out for now; not sure how to pull things from server yet. I just alloc'd a temp array above in the viewdidload.

- (NSDictionary *)allEvents {
    
        
    NSURL *url = [NSURL URLWithString:@"http://idancemarathon.com/user/checklist"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    if(jsonData != nil)
    {
        NSError *error = nil;
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        for (id key in result)
        {
            [sortedKeys addObject:key];
            [[result objectForKey:key] sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        }
        itemsLoaded = YES;
        return result;
    }
    else
    {
        itemsLoaded = NO;
        [sortedKeys addObject:@"Error"];
        return [NSDictionary dictionaryWithObject:[NSArray arrayWithObject:@"Please connect to the internet"] forKey:@"Error"];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker sendView:@"Checklist View"];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
