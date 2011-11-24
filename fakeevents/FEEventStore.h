//
//  FEModel.h
//  fakeevents
//
//  Created by Adam Kirk on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>


@interface FEEventStore : NSObject {
    EKEventStore *eventStore;
    EKCalendar *selectedCalendar;
    NSDate *minDate;
    NSDate *maxDate;
    
    
}

@property (nonatomic, assign) EKEventStore *eventStore;
@property (nonatomic, retain) EKCalendar *selectedCalendar;
@property (nonatomic, retain) NSDate *minDate;
@property (nonatomic, retain) NSDate *maxDate;


+ (FEEventStore *)sharedInstance;
+ (NSArray *)getCalendars;
+ (void)setSelectedCalendar:(EKCalendar *)calendar;
+ (EKCalendar *)getSelectedCalendar;
+ (EKEvent *)newEvent;
+ (NSArray *)getEventsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;
+ (void)saveEvent:(EKEvent *)event;
+ (void)deleteEvent:(EKEvent *)event;

+ (void)setMinDate:(NSDate *)date;
+ (NSDate *)getMinDate;
+ (void)setMaxDate:(NSDate *)date;
+ (NSDate *)getMaxDate;

    
@end
