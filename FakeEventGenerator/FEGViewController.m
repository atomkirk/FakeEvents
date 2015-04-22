//
//  FEGViewController.m
//  FakeEventGenerator
//
//  Created by Adam Kirk on 9/26/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "FEGViewController.h"
#import "FEGSelectDateViewController.h"
#import "FEEventStore.h"
#import "FEFakeData.h"
#import <EventKit/EventKit.h>


@interface FEGViewController () <UITextFieldDelegate, FEGSelectDateViewControllerDelegate>
{
    __weak IBOutlet UIButton                *_setMinDateButton;
    __weak IBOutlet UIButton                *_setMaxDateButton;
    __weak IBOutlet UITextField             *_howManyEventsTextField;
    __weak IBOutlet UITextField             *_howManyRemindersTextField;
    __weak IBOutlet UIActivityIndicatorView *_spinner;
    __weak IBOutlet UILabel                 *_loadingStatusLabel;
    __weak IBOutlet UITableView             *_tableView;
}
@end


@implementation FEGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set default min date
	NSDate *minDate = [[NSDate date] dateByAddingTimeInterval:-(60 * 60 * 24 * 30 * 6)];
    [FEEventStore setMinDate:minDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [_setMinDateButton setTitle:[dateFormatter stringFromDate:minDate] forState:UIControlStateNormal];

	// set default max date
	NSDate *maxDate = [[NSDate date] dateByAddingTimeInterval:(60 * 60 * 24 * 30 * 6)];
    [FEEventStore setMaxDate:maxDate];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [_setMaxDateButton setTitle:[dateFormatter stringFromDate:maxDate] forState:UIControlStateNormal];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[FEEventStore sharedInstance].eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        [[FEEventStore sharedInstance].eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
            [[FEEventStore sharedInstance].eventStore reset];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_tableView reloadData];
                [_howManyEventsTextField becomeFirstResponder];
            }];
        }];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"SelectMinDateSegue"]) {
        FEGSelectDateViewController *controller = [segue destinationViewController];
        controller.delegate = self;
        controller.type = FEGSelectDateViewControllerTypeMin;
        controller.defaultDate = [FEEventStore sharedInstance].minDate;
    }
    else if ([segue.identifier isEqual:@"SelectMaxDateSegue"]) {
        FEGSelectDateViewController *controller = [segue destinationViewController];
        controller.delegate = self;
        controller.type = FEGSelectDateViewControllerTypeMax;
        controller.defaultDate = [FEEventStore sharedInstance].maxDate;
    }
}




#pragma mark - Actions

- (IBAction)addEvents:(id)sender
{
    [_spinner startAnimating];

	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
	    NSString *howMany = _howManyEventsTextField.text;
        NSArray *eventCalendars = [FEEventStore eventCalendars];
		for (int i = 0; i < [howMany intValue]; i++) {
            EKCalendar *calendar = eventCalendars[rand() % [eventCalendars count]];
			EKEvent *event = [FEEventStore newEvent];
			event.calendar = calendar;
			event.startDate = [FEFakeData generateRandomStartDate];
			event.endDate = [FEFakeData generateRandomEndDateGivenStartDate:event.startDate];
			if (rand() % 20 != 0) event.title = [FEFakeData generateRandomTitle];
			if (rand() % 2 == 0) event.alarms = [FEFakeData generateRandomAlarms];
			if (rand() % 10 == 0) event.allDay = [FEFakeData generateRandomAllDay];
			if (rand() % 10 == 0) event.availability = [FEFakeData generateRandomAvailability];
			if (rand() % 5 == 0) event.location = [FEFakeData generateRandomLocation];
			if (rand() % 5 == 0) event.notes = [FEFakeData generateRandomNote];
			if (rand() % 5 == 0) event.recurrenceRules = @[[FEFakeData generateRandomRecurrenceRuleWithEndDate:[FEFakeData generateRandomEndDateGivenStartDate:event.endDate]]];
            event.timeZone = [NSTimeZone localTimeZone];
			[FEEventStore saveEvent:event];

			NSString *status = [NSString stringWithFormat:@"%d/%d Events", i, [howMany intValue]];
			dispatch_async(dispatch_get_main_queue(), ^(void) {
				_loadingStatusLabel.text = status;
			});
		}

        NSArray *reminderCalendars = [FEEventStore reminderCalendars];
	    howMany = _howManyRemindersTextField.text;
        if ([reminderCalendars count] > 0) {
            NSCalendar *systemCalendar = [NSCalendar autoupdatingCurrentCalendar];
            for (int i = 0; i < [howMany intValue]; i++) {
                EKCalendar *calendar = reminderCalendars[rand() % [reminderCalendars count]];
                EKReminder *reminder = [FEEventStore newReminder];
                reminder.calendar = calendar;
                NSDate *dueDate = [FEFakeData generateRandomStartDate];
                NSCalendarUnit units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
                NSDateComponents *components = [systemCalendar components:units fromDate:dueDate];
                if (rand() % 10 == 0) {
                    components.hour = NSDateComponentUndefined;
                    components.minute = NSDateComponentUndefined;
                }
                reminder.dueDateComponents = components;
                if (rand() % 10 == 0) reminder.completionDate = [FEFakeData generateRandomStartDate];
                if (rand() % 20 != 0) reminder.title = [FEFakeData generateRandomTitle];
                if (rand() % 2 == 0) reminder.alarms = [FEFakeData generateRandomAlarms];
                if (rand() % 5 == 0) reminder.location = [FEFakeData generateRandomLocation];
                if (rand() % 5 == 0) reminder.notes = [FEFakeData generateRandomNote];
                if (rand() % 5 == 0) reminder.recurrenceRules = @[[FEFakeData
                                                                   generateRandomRecurrenceRuleWithEndDate:
                                                                   [FEFakeData generateRandomEndDateGivenStartDate:dueDate]]];
                if (rand() % 20 == 0) {
                    reminder.startDateComponents    = nil;
                    reminder.dueDateComponents      = nil;
                    reminder.completionDate         = nil;
                }
                reminder.timeZone = [NSTimeZone localTimeZone];
                [FEEventStore saveReminder:reminder];

                NSString *status = [NSString stringWithFormat:@"%d/%d Reminders", i, [howMany intValue]];
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    _loadingStatusLabel.text = status;
                });
            }
        }

		dispatch_async(dispatch_get_main_queue(), ^(void) {
			_loadingStatusLabel.text = @"";
			[_spinner stopAnimating];
		});
	});
}

- (IBAction)deleteAllEvents:(id)sender
{
	[_spinner startAnimating];

	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
		NSDate *minDate = [FEEventStore getMinDate];
		NSDate *maxDate = [FEEventStore getMaxDate];
		NSArray *events = [FEEventStore getEventsFromDate:minDate toDate:maxDate];
		int count = 0;
		for (EKEvent *event in events) {
			if (event.calendar.allowsContentModifications) {
				[FEEventStore deleteEvent:event];

				NSString *status = [NSString stringWithFormat:@"%@/%@", @(count++), @(events.count)];
				dispatch_async(dispatch_get_main_queue(), ^(void) {
					_loadingStatusLabel.text = status;
				});
			}
		}

        [FEEventStore getRemindersWithCompletion:^(NSArray *reminders) {
            for (EKReminder *reminder in reminders) {
                [FEEventStore deleteReminder:reminder];
            }
        }];

		dispatch_async(dispatch_get_main_queue(), ^(void) {
			_loadingStatusLabel.text = @"";
			[_spinner stopAnimating];
		});
	});
}




#pragma mark - DELEGATE date picker view controller

- (void)selectDateViewController:(FEGSelectDateViewController *)controller selectedDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *dateString = [dateFormatter stringFromDate:date];

    if (controller.type == FEGSelectDateViewControllerTypeMin) {
        [_setMinDateButton setTitle:dateString forState:UIControlStateNormal];
        [FEEventStore setMinDate:date];
    }
    else if (controller.type == FEGSelectDateViewControllerTypeMax) {
        [_setMaxDateButton setTitle:dateString forState:UIControlStateNormal];
        [FEEventStore setMaxDate:date];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}





#pragma mark - DELEGATE text field

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if ([string isEqualToString:@"\n"]) {
		[textField resignFirstResponder];
		return NO;
	} else {
        NSRange r = [string rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]];
        if (r.location == NSNotFound) {
            return NO;
        }
    }
	return YES;
}




#pragma mark - Private

- (void)updateLoadingWithStatus:(NSString *)status
{
    _loadingStatusLabel.text = status;
}


@end
