//
//  FakeDataTests.m
//  fakeevents
//
//  Created by Adam Kirk on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FakeDataTests.h"


@implementation FakeDataTests

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void)testAppDelegate {
    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
    
}

#else                           // all code under test must be linked into the Unit Test bundle

- (void)testGenerateRandomAlarm {
    for (int i = 0; i < 1000; i++) {
        EKAlarm *alarm = [FEFakeData generateRandomAlarm];
        STAssertTrue(alarm.relativeOffset <= 0 && alarm.relativeOffset >= -2592000, @"invalid relative offset %d", alarm.relativeOffset);
    }
}

- (void)testGenerateRandomAlarms {
    NSArray * array = [FEFakeData generateRandomAlarms];
    STAssertTrue(array.count >= 0 && array.count < 6, @"wrong count of elements");
}

- (void)testGenerateRandomAllDay {
    for (int i = 0; i < 1000; i++) {
        BOOL allDay = [FEFakeData generateRandomAllDay];
        STAssertTrue(allDay == YES || allDay == NO, @"all day value not valid");
    }
}

- (void)testGenerateRandomAvailability {
    for (int i = 0; i < 1000; i++) {
        EKEventAvailability availability = [FEFakeData generateRandomAvailability];
        STAssertTrue(availability == EKEventAvailabilityNotSupported ||
                     availability == EKEventAvailabilityBusy ||
                     availability == EKEventAvailabilityFree ||
                     availability == EKEventAvailabilityTentative ||
                     availability == EKEventAvailabilityUnavailable
                     , @"all day value not valid");
    }
}

- (void)testGenerateRandomDates {
    for (int i = 0; i < 1000; i++) {
        NSDate *startDate = [FEFakeData generateRandomStartDate];
        NSDate *endDate = [FEFakeData generateRandomEndDateGivenStartDate:startDate];
        STAssertTrue([startDate timeIntervalSince1970] > 0, @"startDate was not a valid date");
        STAssertTrue([endDate timeIntervalSince1970] > 0, @"endDate was not a valid date");
    }
}

- (void)testGenerateRandomLocation {
    for (int i = 0; i < 1000; i++) {
        NSString *location = [FEFakeData generateRandomLocation];
        STAssertTrue(![location isEqualToString:@""], @"Location was an empty string");
    }
}

- (void)testGenerateRandomNote {
    for (int i = 0; i < 1000; i++) {
        NSString *note = [FEFakeData generateRandomNote];
        STAssertTrue(![note isEqualToString:@""], @"Notes was an empty string");
    }
}

- (void)testGenerateRandomRecurrenceRule {
    for (int i = 0; i < 1000; i++) {
        NSDate *startDate = [FEFakeData generateRandomStartDate];
        NSDate *endDate = [FEFakeData generateRandomEndDateGivenStartDate:startDate];
        EKRecurrenceRule *rule = [FEFakeData generateRandomRecurrenceRuleWithEndDate:endDate];
        STAssertNotNil(rule, @"Recurrence rule should not be nil");
    }
}

- (void)testGenerateRandomTitle {
    for (int i = 0; i < 1000; i++) {
        NSString *title = [FEFakeData generateRandomTitle];
        STAssertTrue(![title isEqualToString:@""], @"Title was an empty string");
    }
}

#endif

@end
