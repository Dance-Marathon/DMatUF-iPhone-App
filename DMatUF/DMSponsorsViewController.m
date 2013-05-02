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

#import "DMSponsorsViewController.h"

@interface DMSponsorsViewController ()

@end

@implementation DMSponsorsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
- (IBAction)done:(id)sender {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dominosCall:(id)sender
{
    CGRect webFrame = CGRectMake(0.0, 0.0, 320.0, 480);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webFrame];
    NSString *urlAddress = @"http://www.gatordominos.com";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view = webView;
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonItemStyleBordered target:self action:@selector(done:)];
    viewController.navigationItem.title = @"Dominos";
    [self presentViewController:navigationController animated:YES completion:nil];
}


- (IBAction)dreamsCall:(id)sender {
    CGRect webFrame = CGRectMake(0.0, 0.0, 320.0, 480);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webFrame];
    NSString *urlAddress = @"http://www.gainesvilleicecream.com";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view = webView;
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonItemStyleBordered target:self action:@selector(done:)];
    viewController.navigationItem.title = @"Sweet Dreams";
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)kissCall:(id)sender {
    CGRect webFrame = CGRectMake(0.0, 0.0, 320.0, 480);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webFrame];
    NSString *urlAddress = @"http://www.kiss1053.com";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view = webView;
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonItemStyleBordered target:self action:@selector(done:)];
    viewController.navigationItem.title = @"Kiss 105.3";
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)sunCall:(id)sender {
    CGRect webFrame = CGRectMake(0.0, 0.0, 320.0, 480);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webFrame];
    NSString *urlAddress = @"http://www.gainesville.com";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view = webView;
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonItemStyleBordered target:self action:@selector(done:)];
    viewController.navigationItem.title = @"Gainesville Sun";
    [self presentViewController:navigationController animated:YES completion:nil];
}*/

- (IBAction)dominosCall:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dominos" message:@"" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Open Website",  nil];
    [alert setTag:01];
    [alert show];
}

- (IBAction)dreamsCall:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sweet Dreams" message:@"" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Open Website",  nil];
    [alert setTag:02];
    [alert show];
}

- (IBAction)kissCall:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Kiss 105.3" message:@"" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Open Website",  nil];
    [alert setTag:03];
    [alert show];
}

- (IBAction)sunCall:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gainesville Sun" message:@"" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Open Website",  nil];
    [alert setTag:04];
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *url = [NSString alloc];

    if (buttonIndex != alertView.cancelButtonIndex)
    {
        switch (alertView.tag)
        {
            case (01):
                if (buttonIndex == 1)
                    url = @"http://gatordominos.com";
                break;
            case (02):
                if (buttonIndex == 1)
                    url = @"http://www.gainesvilleicecream.com";
                    else if (buttonIndex == 2)
                        url = @"tel://3523780532";
                break;
            case (03):
                if (buttonIndex == 1)
                    url = @"http://www.kiss1053.com";
                break;
            case (04):
                if (buttonIndex == 1)
                    url = @"http://www.gainesville.com/";
                break;

        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}


-(void)callNumber:(NSString *)number
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]];
}

- (void)viewDidLoad
{
    [_callLabel setFont:[UIFont fontWithName:@"AG Book Rounded" size:18.0]];
    self.trackedViewName = @"Sponsors View";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
