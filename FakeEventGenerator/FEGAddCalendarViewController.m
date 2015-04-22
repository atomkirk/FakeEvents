//
//  FEGAddCalendarViewController.m
//  FakeEventGenerator
//
//  Created by Adam Kirk on 10/17/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "FEGAddCalendarViewController.h"
#import "FEEventStore.h"
#import "UIColor+Calvetica.h"


@interface FEGAddCalendarViewController ()
@property (weak, nonatomic) IBOutlet UITextField *calendarTitleTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *calendarTypeSegmentedControl;
@property (nonatomic, strong) NSArray *colors;
@end


@implementation FEGAddCalendarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.calendarTitleTextField becomeFirstResponder];
    self.colors = [UIColor colorfulPalette];
}



#pragma mark - Actions

- (IBAction)saveButtonTapped:(id)sender
{
    EKEntityType type       = self.calendarTypeSegmentedControl.selectedSegmentIndex == 0 ? EKEntityTypeEvent : EKEntityTypeReminder;
    EKCalendar *calendar    = [EKCalendar calendarForEntityType:type eventStore:[FEEventStore sharedInstance].eventStore];
    calendar.title          = self.calendarTitleTextField.text;
    calendar.source         = [self goodSource];
    calendar.CGColor        = [UIColor randomColorFromPalette:self.colors].CGColor;
    NSError *error          = nil;
    [[FEEventStore sharedInstance].eventStore saveCalendar:calendar commit:YES error:&error];
    [self cancelButtonTapped:sender];
}

- (IBAction)cancelButtonTapped:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addDefaultCalendarsButtonPressed:(id)sender
{
    NSArray *names = @[@"Work", @"Family", @"Trips", @"Finance", @"Church", @"Sports"];
    EKSource *source = [self goodSource];

    NSUInteger index = 0;
    for (NSString *name in names) {
        EKCalendar *calendar    = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:[FEEventStore sharedInstance].eventStore];
        calendar.title          = name;
        calendar.source         = source;
        calendar.CGColor        = ((UIColor *)self.colors[index++]).CGColor;
        NSError *error          = nil;
        [[FEEventStore sharedInstance].eventStore saveCalendar:calendar commit:YES error:&error];
    }

    for (NSString *name in names) {
        EKCalendar *calendar    = [EKCalendar calendarForEntityType:EKEntityTypeReminder eventStore:[FEEventStore sharedInstance].eventStore];
        calendar.title          = name;
        calendar.source         = source;
        calendar.CGColor        = ((UIColor *)self.colors[index++]).CGColor;
        NSError *error          = nil;
        [[FEEventStore sharedInstance].eventStore saveCalendar:calendar commit:YES error:&error];
    }
    [self cancelButtonTapped:sender];
}


#pragma mark - Private

- (EKSource *)goodSource
{
    return [[[FEEventStore sharedInstance].eventStore.sources filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        EKSource *source = (EKSource *)evaluatedObject;
        return source.sourceType == EKSourceTypeLocal || source.sourceType == EKSourceTypeCalDAV || source.sourceType == EKSourceTypeMobileMe;
    }]] lastObject];
}


@end
