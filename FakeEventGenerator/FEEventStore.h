//
//  FEModel.h
//  fakeevents
//
//  Created by Adam Kirk on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>


@interface FEEventStore : NSObject

@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, strong) EKCalendar *selectedCalendar;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;

+ (FEEventStore *)sharedInstance;
+ (NSArray *)eventCalendars;
+ (NSArray *)reminderCalendars;
+ (EKEvent *)newEvent;
+ (EKReminder *)newReminder;
+ (NSArray *)getEventsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;
+ (void)getRemindersWithCompletion:(void (^)(NSArray *reminders))completion;
+ (void)saveEvent:(EKEvent *)event;
+ (void)deleteEvent:(EKEvent *)event;
+ (void)saveReminder:(EKReminder *)reminder;
+ (void)deleteReminder:(EKReminder *)reminder;

+ (void)setMinDate:(NSDate *)date;
+ (NSDate *)getMinDate;
+ (void)setMaxDate:(NSDate *)date;
+ (NSDate *)getMaxDate;

    
@end
