//
//  SPDemoViewController.m
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 31/03/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import "SPDemoViewController.h"
#import "SPDateTextField.h"
#import "SPPickerTextField.h"

@interface SPDemoViewController ()

@property (nonatomic, strong) IBOutlet SPDateTextField *dateButton;
@property (nonatomic, strong) IBOutlet SPDateTextField *shortDateButton;
@property (nonatomic, strong) IBOutlet SPDateTextField *customDateButton;
@property (nonatomic, strong) IBOutlet SPDateTextField *customTimeButton;

@property (nonatomic, strong) IBOutlet SPPickerTextField *pickerExample1Button;
@property (nonatomic, strong) IBOutlet SPPickerTextField *pickerExample2Button;
@property (nonatomic, strong) IBOutlet SPPickerTextField *pickerExample3Button;

@end

@implementation SPDemoViewController

-(IBAction)doApply:(id)sender
{
    NSString *message = @"";
    
    message = [message stringByAppendingFormat:@"datebutton [%@]\n", [self.dateButton date]];
    message = [message stringByAppendingFormat:@"shortDateButton [%@]\n", [self.shortDateButton date]];
    message = [message stringByAppendingFormat:@"customDateButton [%@]\n", [self.customDateButton date]];
    message = [message stringByAppendingFormat:@"customTimeButton [%@]\n", [self.customTimeButton date]];

    message = [message stringByAppendingString:@"\n"];
    
    message = [message stringByAppendingFormat:@"pickerExample1Button [%@]\n", [self.pickerExample1Button selectedValues]];
    message = [message stringByAppendingFormat:@"pickerExample2Button [%@]\n", [self.pickerExample2Button selectedValues]];
    message = [message stringByAppendingFormat:@"pickerExample3Button [%@]\n", [self.pickerExample3Button selectedValues]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Results" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /////////////////////
    // SPDateButton
    ////////////////
    
    // First date button
    [self.dateButton.datePicker setDate:[NSDate date]];
    
    // Short date button
    [self.shortDateButton.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.shortDateButton.datePicker setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:- (60 * 60 * 24 * 2)]];
    [self.shortDateButton.datePicker setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:(60 * 60 * 24 * 2)]];
    NSDateFormatter *dateFormatterShortDate = [[NSDateFormatter alloc] init];
    [dateFormatterShortDate setDateStyle:NSDateFormatterFullStyle];
    [self.shortDateButton setDateFormatter:dateFormatterShortDate];
    
    // Custom date button
    [self.customDateButton.datePicker setDatePickerMode:UIDatePickerModeDate];
    NSDateFormatter *dateFormatterCustomDate = [[NSDateFormatter alloc] init];
    [dateFormatterCustomDate setDateFormat:@"dd/MM/yyyy"];
    [self.customDateButton setDateFormatter:dateFormatterCustomDate];
    
    // Custom time button
    [self.customTimeButton.datePicker setDatePickerMode:UIDatePickerModeTime];
    NSDateFormatter *dateFormatterCustomTime = [[NSDateFormatter alloc] init];
    [dateFormatterCustomTime setDateFormat:@"HH:mm:SS"];
    [self.customTimeButton setDateFormatter:dateFormatterCustomTime];
    [self.customTimeButton setPlaceholder:@"Please pick a time"];
    
    /////////////////////
    // SPPickerButton
    ////////////////
    
    // Simple picker
    [self.pickerExample1Button setPlaceholder:@"Pick a value"];
    NSDictionary *valueAExample1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @0, PICKER_BUTTON_KEY_VALUE, @"Miss", PICKER_BUTTON_KEY_TITLE,
                                    nil];
    NSDictionary *valueBExample1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @1, PICKER_BUTTON_KEY_VALUE, @"Madam", PICKER_BUTTON_KEY_TITLE,
                                    nil];
    NSDictionary *valueCExample1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @2, PICKER_BUTTON_KEY_VALUE, @"Mister", PICKER_BUTTON_KEY_TITLE,
                                    nil];
    NSArray *valuesExample1 = [NSArray arrayWithObjects:valueAExample1, valueBExample1, valueCExample1, nil];
    NSArray *pickerValues = [NSArray arrayWithObject:valuesExample1];
    [self.pickerExample1Button setPickerValues:pickerValues];
    
    // Multiple picker
    [self.pickerExample2Button setPlaceholder:@"Pick some values"];
    [self.pickerExample2Button setFormat:@"%@, %@, %@"];
    [self.pickerExample2Button addPickerValue:@"#FF0000" forTitle:@"Red" forComponent:0];
    [self.pickerExample2Button addPickerValue:@"#00FF00" forTitle:@"Green" forComponent:0];
    [self.pickerExample2Button addPickerValue:@"#0000FF" forTitle:@"Blue" forComponent:0];
    [self.pickerExample2Button addPickerValue:@"#FF0000" forTitle:@"Red" forComponent:1];
    [self.pickerExample2Button addPickerValue:@"#00FF00" forTitle:@"Green" forComponent:1];
    [self.pickerExample2Button addPickerValue:@"#0000FF" forTitle:@"Blue" forComponent:1];
    [self.pickerExample2Button addPickerValue:@"#FF0000" forTitle:@"Red" forComponent:2];
    [self.pickerExample2Button addPickerValue:@"#00FF00" forTitle:@"Green" forComponent:2];
    [self.pickerExample2Button addPickerValue:@"#0000FF" forTitle:@"Blue" forComponent:2];
    
    // Advanced picker
    [self.pickerExample3Button setPlaceholder:@"Please pick these values"];
    [self.pickerExample3Button setFormat:@"%@ -> %@"];
    [self.pickerExample3Button addPickerValue:[NSNumber numberWithBool:YES] forTitle:@"Yes" forComponent:0];
    [self.pickerExample3Button addPickerValue:[NSNumber numberWithBool:NO] forTitle:@"No" forComponent:0];
    [self.pickerExample3Button addPickerValue:[NSURL URLWithString:@"http://www.google.com"] forTitle:@"Google" forComponent:1];
    [self.pickerExample3Button addPickerValue:[NSURL URLWithString:@"http://www.yahoo.com"] forTitle:@"Yahoo" forComponent:1];
    [self.pickerExample3Button addPickerValue:[NSURL URLWithString:@"http://www.bing.com"] forTitle:@"Bing" forComponent:1];
}

@end
