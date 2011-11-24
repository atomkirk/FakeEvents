//
//  FECalendarChooser.h
//  fakeevents
//
//  Created by Adam Kirk on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "FEEventStore.h"


@interface FECalendarChooser : UITableViewController {
    NSArray *calendars;
}

@property (nonatomic, retain) NSArray *calendars;

@end
