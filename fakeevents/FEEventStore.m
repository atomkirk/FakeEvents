//
//  FEModel.m
//  fakeevents
//
//  Created by Adam Kirk on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FEEventStore.h"

static FEEventStore *sharedInstance = nil;

@implementation FEEventStore

@synthesize eventStore;
@synthesize selectedCalendar;
@synthesize minDate;
@synthesize maxDate;



+ (FEEventStore *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
        sharedInstance.eventStore = [[EKEventStore alloc] init];
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedInstance] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

- (NSDate *)minDate {
    if (minDate) {
        return minDate;
    }
    return [[NSDate date] dateByAddingTimeInterval:-(60*60*24*365)];
}

- (NSDate *)maxDate {
    if (maxDate) {
        return maxDate;
    }
    return [[NSDate date] dateByAddingTimeInterval:(60*60*24*365)];
}



+ (NSArray *)getCalendars {
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSArray *calendars = instance.eventStore.calendars;
    NSMutableArray *editableCalendars = [NSMutableArray array];
    for (EKCalendar *c in calendars) {
        if (c.allowsContentModifications) {
            [editableCalendars addObject:c];
        }
    }
    return editableCalendars;
}



+ (void)setSelectedCalendar:(EKCalendar *)calendar {
    FEEventStore *instance = [FEEventStore sharedInstance];
    instance.selectedCalendar = calendar;
}

+ (EKCalendar *)getSelectedCalendar {
    FEEventStore *instance = [FEEventStore sharedInstance];
    return instance.selectedCalendar;
}

+ (void)setMinDate:(NSDate *)date {
    FEEventStore *instance = [FEEventStore sharedInstance];
    instance.minDate = date;
}

+ (NSDate *)getMinDate {
    FEEventStore *instance = [FEEventStore sharedInstance];
    return instance.minDate;
}

+ (void)setMaxDate:(NSDate *)date {
    FEEventStore *instance = [FEEventStore sharedInstance];
    instance.maxDate = date;
}

+ (NSDate *)getMaxDate {
    FEEventStore *instance = [FEEventStore sharedInstance];
    return instance.maxDate;
}

+ (EKEvent *)newEvent {
    FEEventStore *instance = [FEEventStore sharedInstance];
    return [EKEvent eventWithEventStore:instance.eventStore];
}


+ (NSArray *)getEventsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSPredicate *predicate = [instance.eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
    return [instance.eventStore eventsMatchingPredicate:predicate];
}

+ (void)saveEvent:(EKEvent *)event {
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSError *error;
    [instance.eventStore saveEvent:event span:EKSpanFutureEvents error:&error];
}

+ (void)deleteEvent:(EKEvent *)event {
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSError *error;
    [instance.eventStore removeEvent:event span:EKSpanFutureEvents error:&error];
}

@end
