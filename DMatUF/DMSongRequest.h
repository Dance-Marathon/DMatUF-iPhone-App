//
//  DMSongRequest.h
//  DMatUF
//
//  Created by Matthew Gerstman on 1/2/13.
//  Copyright (c) 2013 DMatUF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMSongRequest : UIViewController {
    NSMutableData *httpResponse;
}
@property (strong, nonatomic) IBOutlet UIButton *songButton;

-(IBAction)songRequest:(id) sender;


@end
