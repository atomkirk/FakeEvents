//
//  FEGCalendarsViewController.m
//  FakeEventGenerator
//
//  Created by Adam Kirk on 10/17/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "FEGCalendarsViewController.h"
#import "FEEventStore.h"


@implementation FEGCalendarsViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}



#pragma mark - Actions

- (IBAction)doneButtonPressed:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [[FEEventStore eventCalendars] count];
    }
    else {
        return [[FEEventStore reminderCalendars] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    EKCalendar *calendar;
    if (indexPath.section == 0) {
        calendar = [FEEventStore eventCalendars][indexPath.row];
    }
    else {
        calendar = [FEEventStore reminderCalendars][indexPath.row];
    }

    cell.textLabel.text     = calendar.title;
    cell.backgroundColor    = [UIColor colorWithCGColor:calendar.CGColor];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EKCalendar *calendar;
        if (indexPath.section == 0) {
            calendar = [FEEventStore eventCalendars][indexPath.row];
        }
        else {
            calendar = [FEEventStore reminderCalendars][indexPath.row];
        }
        [[FEEventStore sharedInstance].eventStore removeCalendar:calendar commit:YES error:nil];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Event Calendars";
    }
    else {
        return @"Reminder Calendars";
    }
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//
//}

@end
