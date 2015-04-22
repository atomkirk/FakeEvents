//
//  FEGSelectDateViewController.h
//  FakeEventGenerator
//
//  Created by Adam Kirk on 9/26/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

typedef NS_ENUM(NSUInteger, FEGSelectDateViewControllerType) {
    FEGSelectDateViewControllerTypeMin,
    FEGSelectDateViewControllerTypeMax
};


@protocol FEGSelectDateViewControllerDelegate;


@interface FEGSelectDateViewController : UIViewController
@property (nonatomic, weak) id<FEGSelectDateViewControllerDelegate> delegate;
@property (nonatomic, assign) FEGSelectDateViewControllerType type;
@property (nonatomic, strong) NSDate *defaultDate;
@end



@protocol FEGSelectDateViewControllerDelegate <NSObject>
- (void)selectDateViewController:(FEGSelectDateViewController *)controller selectedDate:(NSDate *)date;
@end