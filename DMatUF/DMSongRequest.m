//
//  DMSongRequest.m
//  DMatUF
//
//  Created by Matthew Gerstman on 1/2/13.
//  Copyright (c) 2013 DMatUF. All rights reserved.
//

#import "DMSongRequest.h"

@interface DMSongRequest ()

@end

@implementation DMSongRequest

-(IBAction)songRequest:(id) sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Request a song" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;
    alertTextField.placeholder = @"Enter the song title";
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
                
                NSURL *aUrl = [NSURL URLWithString:@"http://www.mattgerstman.com/dmiphone/songs.php"];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                                       cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                   timeoutInterval:60.0];
                
                
                [request setHTTPMethod:@"POST"];
                NSString *postString = [NSString stringWithFormat:@"track=%@", textField.text];
                [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO]];
                
                NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request
                                                                             delegate:self];
                
                
                break;
            }
        }
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
