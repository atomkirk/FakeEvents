//
//  FEFakeContactsViewController.h
//  fakeevents
//
//  Created by Adam Kirk on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

#import "FEEventStore.h"
#import "FEFakeData.h"
#import "FESelectMinDateViewController.h"
#import "FESelectMaxDateViewController.h"

@interface FEFakeContactsViewController : UIViewController <UITextFieldDelegate> {
    UITextField *howManyTextField;
    UIActivityIndicatorView *spinner;
    UIDatePicker *minDatePicker;
    UIDatePicker *maxDatePicker;
    UIButton *doneSelectingMaxDate;
    FESelectMinDateViewController *selectMinDateViewController;
    FESelectMaxDateViewController *selectMaxDateViewController;
    UIButton *setMinDateButton;
    UIButton *setMaxDateButton;
    UILabel *loadingStatusLabel;
}


@property (nonatomic, retain) IBOutlet FESelectMinDateViewController *selectMinDateViewController;
@property (nonatomic, retain) IBOutlet FESelectMaxDateViewController *selectMaxDateViewController;

@property (nonatomic, retain) IBOutlet UIButton *setMinDateButton;
@property (nonatomic, retain) IBOutlet UIButton *setMaxDateButton;

- (IBAction)showMinDatePicker:(id)sender;
- (IBAction)showMaxDatePicker:(id)sender;


@property (nonatomic, retain) IBOutlet UIDatePicker *minDatePicker;
@property (nonatomic, retain) IBOutlet UIDatePicker *maxDatePicker;

- (IBAction)doneSelectingMinDate:(id)sender;
- (IBAction)cancelSelectingMinDate:(id)sender;
- (IBAction)doneSelectingMaxDate:(id)sender;
- (IBAction)cancelSelectingMaxDate:(id)sender;


@property (nonatomic, retain) IBOutlet UITextField *howManyTextField;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)addEvents:(id)sender;
- (IBAction)deleteAllEvents:(id)sender;

@property (nonatomic, retain) IBOutlet UILabel *loadingStatusLabel;

@end
