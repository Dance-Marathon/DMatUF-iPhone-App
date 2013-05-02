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

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#include "Reachability.h"


@interface DMLinedanceViewController : GAITrackedViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *linedanceView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *exitButton;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)exitView:(id)sender;


@end
