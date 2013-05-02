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
#import "DMFirstViewController.h"


@interface DMFirstViewController ()

@end

@implementation DMFirstViewController

-(IBAction)learnLinedance:(id)sender
{
    NSString *stringURL = @"http://www.youtube.com/watch?v=Yi3ADsip-dA";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)donate:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://floridadm.kintera.org"]];
}


-(IBAction)songRequest:(id) sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Request a Song" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;
    alertTextField.placeholder = @"Song Title";
    
    httpResponse = [[NSMutableData alloc] init];
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)  // 0 == the cancel button
    {
        //  Since we don't have a pointer to the textfield, we're
        //  going to need to traverse the subviews to find our
        //  UITextField in the hierarchy
        for (UIView* view in alertView.subviews)
        {
            if ([view isKindOfClass:[UITextField class]])
            {
                UITextField* textField = (UITextField*)view;

                NSLog(@"text:[%@]", textField.text);
                
                NSURL *aUrl = [NSURL URLWithString:@"http://www.iDancemarathon.com/user/addSong"];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                                       cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                                   timeoutInterval:60.0];
           
                
                [request setHTTPMethod:@"POST"];
                NSString *postString = [NSString stringWithFormat:@"track=%@", textField.text];
                [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO]];
                NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
             
                break;
            }
        }
    }
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL* absURL=[request.mainDocumentURL absoluteURL];
    NSString* sURL=[absURL absoluteString];
    
    if ([@"http://www.idancemarathon.com/user/main_test" isEqualToString:sURL]) {
        return YES;
    }
    else if ([@"objc://tweet" isEqualToString:sURL]) {
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController
                                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"#DMatUF "];
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
        
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Sorry"
                                      message:@"You can't send a tweet right now. Make sure your device has an internet connection and you have at least one Twitter account setup."
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
        }
        
        return NO;
    }
    else  if (navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString* responseString = [[NSString alloc] initWithData:httpResponse encoding:NSUTF8StringEncoding];
    
    // Do something with the response
    NSLog(@"Response: %@", responseString);

}

- (void)loadWebView
{
    if ([self checkInternet])
    {
        NSString *fullURL = @"http://www.idancemarathon.com/user/main_test";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];

        [_mainView loadRequest:request];
        _mainView.scrollView.bounces = NO;
        NSLog(@"Connected");
    }
    else
    {
        
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
        NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];

        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        
        [_mainView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
        _mainView.scrollView.bounces = NO;
        NSLog(@"Not Connected");
    }
}


- (void)viewDidLoad
{

    
    UIImage *buttonBackground = [[UIImage imageNamed:@"blueButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [_linedanceButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [_linedanceButton.titleLabel setFont:[UIFont fontWithName:@"AG Book Rounded" size:12.0]];
    [_linedanceButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_linedanceButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_songButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [_songButton.titleLabel setFont:[UIFont fontWithName:@"AG Book Rounded" size:12.0]];
    [_songButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_songButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_donateButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [_donateButton.titleLabel setFont:[UIFont fontWithName:@"AG Book Rounded" size:12.0]];
   
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadWebView
                                                                )
                                                 name:kReachabilityChangedNotification object:nil];
    
 
    [self loadWebView];
    self.trackedViewName = @"Main View";

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadWebView) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
    
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

//Indicator

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicator startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicator stopAnimating];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString* htmlString = [NSString stringWithContentsOfFile:@"index.html" encoding:NSUTF8StringEncoding error:nil];
    [_mainView loadHTMLString:htmlString baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
