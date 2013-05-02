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
#import "DMMainViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface DMMainViewController ()

@end

@implementation DMMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    for(UIViewController *tab in  self.tabBarController.viewControllers)
        
    {
        [tab.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIFont fontWithName:@"agbookroucffmed" size:20.0], UITextAttributeFont, nil]
                                      forState:UIControlStateNormal];
    }
    [[self tabBar] setSelectedImageTintColor:UIColorFromRGB(0x014083)];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
