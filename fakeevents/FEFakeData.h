//
//  FEFakeData.h
//  fakeevents
//
//  Created by Adam Kirk on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "FEEventStore.h"

@interface FEFakeData : NSObject {
}

@property (nonatomic, retain) NSArray *wdArray;
@property (nonatomic, retain) NSArray *fnArray;
@property (nonatomic, retain) NSArray *lnArray;
@property (nonatomic, retain) NSArray *snArray;
@property (nonatomic, retain) NSArray *cities;
@property (nonatomic, retain) NSArray *states;

+ (FEFakeData *)sharedInstance;
+ (NSArray *)generateRandomAlarms;
+ (EKAlarm *)generateRandomAlarm;
+ (BOOL)generateRandomAllDay;
+ (EKEventAvailability)generateRandomAvailability;
+ (NSDate *)generateRandomStartDate;
+ (NSDate *)generateRandomEndDateGivenStartDate:(NSDate *)startDate;
+ (NSString *)generateRandomLocation;
+ (NSString *)generateRandomNote;
+ (EKRecurrenceRule *)generateRandomRecurrenceRuleWithEndDate:(NSDate *)endDate;
+ (NSString *)generateRandomTitle;





+ (NSString *)generateRandomStreet;
+ (NSString *)generateRandomCity;
+ (NSString *)generateRandomState;
+ (NSString *)generateRandomZipCode;

+ (EKRecurrenceFrequency)generateRandomRecurrenceFrequency;
+ (NSInteger)generateRandomRecurrenceInterval;
+ (NSArray *)generateRandomDaysOfTheWeek;
+ (NSArray *)generateRandomDaysOfTheMonth;
+ (NSArray *)generateRandomMonthsOfTheYear;
+ (NSArray *)generateRandomWeeksOfTheYear;
+ (NSArray *)generateRandomDaysOfTheYear;

@end
