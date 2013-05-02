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

/*
 * Copyright (c) 2010-2012 Matias Muhonen <mmu@iki.fi>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "DayViewExampleController.h"
#import "MAEvent.h"
#import "MAEventKitDataSource.h"

// Uncomment the following line to use the built in calendar as a source for events:
//#define USE_EVENTKIT_DATA_SOURCE 1

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface DayViewExampleController(PrivateMethods)
@property (readonly) MAEvent *event;
@property (readonly) MAEventKitDataSource *eventKitDataSource;
@end

@implementation DayViewExampleController




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)viewDidLoad {
    
    eventsLoaded = NO;
	MADayView *dayView = (MADayView *) self.view;
	/* The default is not to autoscroll, so let's override the default here */
	dayView.autoScrollToFirstEvent = YES;
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadEvents) name:kReachabilityChangedNotification object:nil];

}

- (void) loadView
{
    CGRect rect = CGRectMake(0.0f, 20.0f, 320.0f, 216.0f);
    MADayView *dayView = [[MADayView alloc] initWithFrame:rect];
    dayView.dataSource = self;
    self.view = dayView;
}

- (void) reloadEvents
{
    if (eventsLoaded == NO)
    {
        [self loadView];
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

/* Implementation for the MADayViewDataSource protocol */

static NSDate *date = nil;

#ifdef USE_EVENTKIT_DATA_SOURCE

- (NSArray *)dayView:(MADayView *)dayView eventsForDate:(NSDate *)startDate {
    return [self.eventKitDataSource dayView:dayView eventsForDate:startDate];
}

#else
- (NSArray *)dayView:(MADayView *)dayView eventsForDate:(NSDate *)startDate {
	date = startDate;
	NSArray *arr = [self allEvents];
    
    
	return arr;
}
#endif

- (NSArray *)allEvents {

    NSMutableArray *events = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"http://www.idancemarathon.com/user/gettimeline"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    if(jsonData != nil)
    {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if (error == nil)
        NSLog(@"%@", result);
    
        for (NSDictionary* event in result)
        {
            [events addObject:[self eventFromJSONObject:event]];
        }
        
        eventsLoaded = YES;
        return [NSArray arrayWithArray:events];
    }
    else
    {
        MAEvent *event = [[MAEvent alloc] init];
        event.textColor = [UIColor whiteColor];
        event.allDay = NO;
        event.title = @"Please connect to the internet";
        event.backgroundColor = UIColorFromRGB(0xf37021);
        
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"HH:mm"];
        NSDate *convertedDate = [df dateFromString:@"00:00"];
        
        NSDateComponents *eventTime = [[NSCalendar currentCalendar] components: DATE_COMPONENTS fromDate: convertedDate];
        
        convertedDate = [df dateFromString:@"01:00"];
        
        NSDateComponents *eventLength = [[NSCalendar currentCalendar] components: DATE_COMPONENTS
                                                                        fromDate: convertedDate];
        
        
        NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
        [components setHour:[eventTime hour]];
        [components setMinute:[eventTime minute]];
        [components setSecond:0];
        
        event.start = [CURRENT_CALENDAR dateFromComponents:components];
        
        
        NSLog(@"Event: %@ at %d:%d", event.title, [eventTime hour], [eventTime minute]);
        
        [components setHour:[eventTime hour] + [eventLength hour]];
        [components setMinute:[eventTime minute] + [eventLength minute]];
        [components setSecond:0];
        event.end = [CURRENT_CALENDAR dateFromComponents:components];
        
        eventsLoaded = NO;
        return [NSArray arrayWithObject:event];;
    }
}

- (MAEvent*)eventFromJSONObject:object
{
	MAEvent *event = [[MAEvent alloc] init];
    NSString *type = [object objectForKey:@"type"];
    if ([type isEqualToString:@"Rave"])
    {
        event.backgroundColor = UIColorFromRGB(0x70309f);
    }
	else if ([type isEqualToString:@"Theme Hour"])
    {
        event.backgroundColor = UIColorFromRGB(0xf37021);
    }
    else if ([type isEqualToString:@"Family"])
    {
        event.backgroundColor = UIColorFromRGB(0xf77cfe);
    }
    else
    {
        event.backgroundColor = UIColorFromRGB(0x014083);
    }
	event.textColor = [UIColor whiteColor];
	event.allDay = NO;
    //if it crashes add a dict value
    event.title = [object objectForKey:@"text"];
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    NSDate *convertedDate = [df dateFromString:[object objectForKey:@"time"]];

    NSDateComponents *eventTime = [[NSCalendar currentCalendar] components: DATE_COMPONENTS fromDate: convertedDate];
    
    convertedDate = [df dateFromString:[object objectForKey:@"length"]];
    
    NSDateComponents *eventLength = [[NSCalendar currentCalendar] components: DATE_COMPONENTS
                                                                  fromDate: convertedDate];
    
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
	[components setHour:[eventTime hour]];
	[components setMinute:[eventTime minute]];
	[components setSecond:0];
	
	event.start = [CURRENT_CALENDAR dateFromComponents:components];
	
	
    NSLog(@"Event: %@ at %d:%d", event.title, [eventTime hour], [eventTime minute]);
    
    [components setHour:[eventTime hour] + [eventLength hour]];
	[components setMinute:[eventTime minute] + [eventLength minute]];
	[components setSecond:0];
    event.end = [CURRENT_CALENDAR dateFromComponents:components];
    
    
    return event;
}

- (MAEventKitDataSource *)eventKitDataSource {
    if (!_eventKitDataSource) {
        _eventKitDataSource = [[MAEventKitDataSource alloc] init];
    }
    return _eventKitDataSource;
}

/* Implementation for the MADayViewDelegate protocol */

- (void)dayView:(MADayView *)dayView eventTapped:(MAEvent *)event {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:event.start];
	NSString *eventInfo = [NSString stringWithFormat:@"Hour %i. Userinfo: %@", [components hour], [event.userInfo objectForKey:@"test"]];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:event.title
													 message:eventInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker sendView:@"Timeline View"];
}




@end
