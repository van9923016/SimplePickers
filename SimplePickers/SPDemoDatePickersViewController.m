//
//  SPDemoDatePickersViewController.m
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 31/03/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import "SPDemoDatePickersViewController.h"
#import "SPDateTextField.h"

@interface SPDemoDatePickersViewController ()

@property (nonatomic, strong) IBOutlet SPDateTextField *dateTextField;
@property (nonatomic, strong) IBOutlet SPDateTextField *shortDateTextField;
@property (nonatomic, strong) IBOutlet SPDateTextField *customDateTextField;
@property (nonatomic, strong) IBOutlet SPDateTextField *customTimeTextField;

@end

@implementation SPDemoDatePickersViewController

-(IBAction)doApply:(id)sender
{
    NSString *message = @"";
    
    message = [message stringByAppendingFormat:@"dateTextField [%@]\n", [self.dateTextField date]];
    message = [message stringByAppendingFormat:@"shortDateTextField [%@]\n", [self.shortDateTextField date]];
    message = [message stringByAppendingFormat:@"customDateTextField [%@]\n", [self.customDateTextField date]];
    message = [message stringByAppendingFormat:@"customTimeTextField [%@]\n", [self.customTimeTextField date]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Results" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /////////////////////
    // SPDateTextField
    ////////////////
    
    // First date TextField
    [self.dateTextField.datePicker setDate:[NSDate date]];
    
    // Short date TextField
    [self.shortDateTextField.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.shortDateTextField.datePicker setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:- (60 * 60 * 24 * 2)]];
    [self.shortDateTextField.datePicker setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:(60 * 60 * 24 * 2)]];
    NSDateFormatter *dateFormatterShortDate = [[NSDateFormatter alloc] init];
    [dateFormatterShortDate setDateStyle:NSDateFormatterFullStyle];
    [self.shortDateTextField setDateFormatter:dateFormatterShortDate];
    
    // Custom date TextField
    [self.customDateTextField.datePicker setDatePickerMode:UIDatePickerModeDate];
    NSDateFormatter *dateFormatterCustomDate = [[NSDateFormatter alloc] init];
    [dateFormatterCustomDate setDateFormat:@"dd/MM/yyyy"];
    [self.customDateTextField setDateFormatter:dateFormatterCustomDate];
    
    // Custom time TextField
    [self.customTimeTextField.datePicker setDatePickerMode:UIDatePickerModeTime];
    NSDateFormatter *dateFormatterCustomTime = [[NSDateFormatter alloc] init];
    [dateFormatterCustomTime setDateFormat:@"HH:mm:SS"];
    [self.customTimeTextField setDateFormatter:dateFormatterCustomTime];
    [self.customTimeTextField setPlaceholder:@"Please pick a time"];
}

@end
