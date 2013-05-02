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

#import "DMLinedanceViewController.h"

@interface DMLinedanceViewController ()

@end

@implementation DMLinedanceViewController

- (IBAction)exitView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    webView.mediaPlaybackRequiresUserAction=FALSE;
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


- (void)loadWebView
{
    if ([self checkInternet])
    {
        NSString *fullURL = @"http://idancemarathon.com/user/linedance";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [_webView loadRequest:request];
        _webView.scrollView.bounces = NO;
        NSLog(@"Connected");
    }
    else
    {
        
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
        NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        
        [_webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
        _webView.scrollView.bounces = NO;
        NSLog(@"Not Connected");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadWebView];
    self.trackedViewName = @"Linedance View";
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
