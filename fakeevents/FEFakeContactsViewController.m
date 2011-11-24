//
//  FEFakeContactsViewController.m
//  fakeevents
//
//  Created by Adam Kirk on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FEFakeContactsViewController.h"


@implementation FEFakeContactsViewController
@synthesize loadingStatusLabel;

@synthesize selectMinDateViewController;
@synthesize selectMaxDateViewController;
@synthesize setMinDateButton;
@synthesize setMaxDateButton;

@synthesize minDatePicker;
@synthesize maxDatePicker;
@synthesize howManyTextField;
@synthesize spinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    [howManyTextField release];
    [spinner release];
    [minDatePicker release];
    [maxDatePicker release];
    [selectMinDateViewController release];
    [selectMaxDateViewController release];
    [setMinDateButton release];
    [setMaxDateButton release];
    [loadingStatusLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// set default min date
	NSDate *minDate = [[NSDate date] dateByAddingTimeInterval:-(60 * 60 * 24 * 30)];
    [FEEventStore setMinDate:minDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    setMinDateButton.titleLabel.text = [dateFormatter stringFromDate:minDate];
	[dateFormatter release];
	
	// set default max date
	NSDate *maxDate = [[NSDate date] dateByAddingTimeInterval:(60 * 60 * 24 * 30)];
    [FEEventStore setMaxDate:maxDate];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    setMaxDateButton.titleLabel.text = [dateFormatter stringFromDate:maxDate];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

- (IBAction)addEvents:(id)sender {
    
    if (![FEEventStore getSelectedCalendar]) {
        loadingStatusLabel.text = @"You must select a calendar";
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:howManyTextField.text forKey:@"howmany"];
    [dict setObject:[FEEventStore getSelectedCalendar] forKey:@"calendar"];  
    [spinner startAnimating];
	
	dispatch_queue_t queue = dispatch_queue_create("com.mysterioustrousers.fakeevents.addevents", NULL);
	dispatch_async(queue, ^(void) {
	    NSString *howMany = [dict objectForKey:@"howmany"];
		EKCalendar *calendar = [dict objectForKey:@"calendar"];
		for (int i = 0; i < [howMany intValue]; i++) {
			
			[NSThread sleepForTimeInterval:0.01];
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
			if (rand() % 5 == 0) event.recurrenceRule = [FEFakeData generateRandomRecurrenceRuleWithEndDate:[FEFakeData generateRandomEndDateGivenStartDate:event.endDate]];
			[FEEventStore saveEvent:event];
			
			NSString *status = [NSString stringWithFormat:@"%d/%d", i, [howMany intValue]];
			dispatch_async(dispatch_get_main_queue(), ^(void) {
				loadingStatusLabel.text = status;
			});
		}
		
		dispatch_async(dispatch_get_main_queue(), ^(void) {
			loadingStatusLabel.text = @"";
			[spinner stopAnimating];
		});
	
	});
}





- (IBAction)deleteAllEvents:(id)sender {
    
	[spinner startAnimating];
	
	dispatch_queue_t queue = dispatch_queue_create("com.mysterioustrousers.fakeevents.deleteevents", NULL);
	dispatch_async(queue, ^(void) {
		NSDate *minDate = [FEEventStore getMinDate];
		NSDate *maxDate = [FEEventStore getMaxDate];
		NSArray *events = [FEEventStore getEventsFromDate:minDate toDate:maxDate];
		int count = 0;
		for (EKEvent *event in events) {
			if (event.calendar.allowsContentModifications) {
				[FEEventStore deleteEvent:event];
				
				NSString *status = [NSString stringWithFormat:@"%d/%d", count++, events.count];
				dispatch_async(dispatch_get_main_queue(), ^(void) {
					loadingStatusLabel.text = status;
				});
			}
		}
		
		dispatch_async(dispatch_get_main_queue(), ^(void) {
			loadingStatusLabel.text = @"";    
			[spinner stopAnimating];
		});
	});
}


- (void)updateLoadingWithStatus:(NSString *)status {
    loadingStatusLabel.text = status;
}




- (IBAction)doneSelectingMinDate:(id)sender {
    NSDate *minDate = minDatePicker.date;
    [FEEventStore setMinDate:minDate];
    [self dismissModalViewControllerAnimated:YES];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    setMinDateButton.titleLabel.text = [dateFormatter stringFromDate:minDate];
}

- (IBAction)cancelSelectingMinDate:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)doneSelectingMaxDate:(id)sender {
    NSDate *maxDate = maxDatePicker.date;
    [FEEventStore setMaxDate:maxDate];
    [self dismissModalViewControllerAnimated:YES];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    setMaxDateButton.titleLabel.text = [dateFormatter stringFromDate:maxDate];
}

- (IBAction)cancelSelectingMaxDate:(id)sender {
    [self dismissModalViewControllerAnimated:YES];    
}

- (IBAction)showMinDatePicker:(id)sender {
    [self presentModalViewController:selectMinDateViewController animated:YES];
}

- (IBAction)showMaxDatePicker:(id)sender {
    [self presentModalViewController:selectMaxDateViewController animated:YES];
}




- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    
    UIView *v = self.view;
    CGRect r = v.frame;
    r.origin.y -= 200;
    [v setFrame:r];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    
    UIView *v = self.view;
    CGRect r = v.frame;
    r.origin.y += 200;
    [v setFrame:r];    
    
    [UIView commitAnimations];
}

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

@end
