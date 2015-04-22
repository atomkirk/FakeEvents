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



+ (NSArray *)eventCalendars
{
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSArray *calendars = [instance.eventStore calendarsForEntityType:EKEntityTypeEvent];
    return [calendars filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKCalendar *calendar, NSDictionary *bindings) {
        return calendar.allowsContentModifications && (calendar.source.sourceType == EKSourceTypeCalDAV ||
                                                       calendar.source.sourceType == EKSourceTypeLocal ||
                                                       calendar.source.sourceType == EKSourceTypeMobileMe);
    }]];
}

+ (NSArray *)reminderCalendars
{
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSArray *calendars = [instance.eventStore calendarsForEntityType:EKEntityTypeReminder];
    return [calendars filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKCalendar *calendar, NSDictionary *bindings) {
        return calendar.allowsContentModifications && (calendar.source.sourceType == EKSourceTypeCalDAV ||
                                                       calendar.source.sourceType == EKSourceTypeLocal ||
                                                       calendar.source.sourceType == EKSourceTypeMobileMe);
    }]];
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

+ (EKReminder *)newReminder
{
    FEEventStore *instance = [FEEventStore sharedInstance];
    return [EKReminder reminderWithEventStore:instance.eventStore];
}

+ (NSArray *)getEventsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSPredicate *predicate = [instance.eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
    return [instance.eventStore eventsMatchingPredicate:predicate];
}

+ (void)getRemindersWithCompletion:(void (^)(NSArray *))completion
{
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSPredicate *predicate = [instance.eventStore predicateForRemindersInCalendars:nil];
    [instance.eventStore fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders) {
        if (completion) completion(reminders);
    }];
}

+ (void)saveEvent:(EKEvent *)event {
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSError *error;
save_event:
    @try {
        [instance.eventStore saveEvent:event span:EKSpanFutureEvents error:&error];
    }
    @catch (NSException *exception) {
        [NSThread sleepForTimeInterval:0.1];
        goto save_event;
    }
}

+ (void)deleteEvent:(EKEvent *)event {
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSError *error;
delete_event:
    @try {
        [instance.eventStore removeEvent:event span:EKSpanFutureEvents error:&error];
    }
    @catch (NSException *exception) {
        [NSThread sleepForTimeInterval:0.1];
        goto delete_event;
    }
}

+ (void)saveReminder:(EKReminder *)reminder {
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSError *error;
save_reminder:
    @try {
        [instance.eventStore saveReminder:reminder commit:YES error:&error];
    }
    @catch (NSException *exception) {
        [NSThread sleepForTimeInterval:0.1];
        goto save_reminder;
    }
}

+ (void)deleteReminder:(EKReminder *)reminder
{
    FEEventStore *instance = [FEEventStore sharedInstance];
    NSError *error;
delete_reminder:
    @try {
        [instance.eventStore removeReminder:reminder commit:YES error:&error];
    }
    @catch (NSException *exception) {
        [NSThread sleepForTimeInterval:0.1];
        goto delete_reminder;
    }
}


@end
