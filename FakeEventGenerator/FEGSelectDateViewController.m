//
//  FEGSelectDateViewController.m
//  FakeEventGenerator
//
//  Created by Adam Kirk on 9/26/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "FEGSelectDateViewController.h"

@implementation FEGSelectDateViewController {
    __weak IBOutlet UIDatePicker *_datePicker;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.type == FEGSelectDateViewControllerTypeMin) {
        self.title = @"Select Min Date";
    }
    else {
        self.title = @"Select Max Date";
    }

    _datePicker.date = self.defaultDate;
}

- (IBAction)datePickerValueDidChange:(UIDatePicker *)sender
{
    [self.delegate selectDateViewController:self selectedDate:sender.date];
}


@end
