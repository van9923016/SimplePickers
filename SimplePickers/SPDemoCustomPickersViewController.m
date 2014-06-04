//
//  SPDemoCustomPickersViewController.m
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 31/03/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import "SPDemoCustomPickersViewController.h"
#import "SPPickerTextField.h"

@interface SPDemoCustomPickersViewController ()

@property (nonatomic, strong) IBOutlet SPPickerTextField *pickerExample1TextField;
@property (nonatomic, strong) IBOutlet SPPickerTextField *pickerExample2TextField;
@property (nonatomic, strong) IBOutlet SPPickerTextField *pickerExample3TextField;

@end

@implementation SPDemoCustomPickersViewController

-(IBAction)doApply:(id)sender
{
    NSString *message = @"";
    
    message = [message stringByAppendingFormat:@"pickerExample1TextField [%@]\n", [self.pickerExample1TextField selectedValues]];
    message = [message stringByAppendingFormat:@"pickerExample2TextField [%@]\n", [self.pickerExample2TextField selectedValues]];
    message = [message stringByAppendingFormat:@"pickerExample3TextField [%@]\n", [self.pickerExample3TextField selectedValues]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Results" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /////////////////////
    // SPPickerTextField
    ////////////////
    
    // Simple picker
    [self.pickerExample1TextField setPlaceholder:@"Pick a value"];
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
    [self.pickerExample1TextField setPickerValues:pickerValues];
    
    // Multiple picker
    [self.pickerExample2TextField setPlaceholder:@"Pick some values"];
    [self.pickerExample2TextField setFormat:@"%@, %@, %@"];
    [self.pickerExample2TextField addPickerValue:@"#FF0000" forTitle:@"Red" forComponent:0];
    [self.pickerExample2TextField addPickerValue:@"#00FF00" forTitle:@"Green" forComponent:0];
    [self.pickerExample2TextField addPickerValue:@"#0000FF" forTitle:@"Blue" forComponent:0];
    [self.pickerExample2TextField addPickerValue:@"#FF0000" forTitle:@"Red" forComponent:1];
    [self.pickerExample2TextField addPickerValue:@"#00FF00" forTitle:@"Green" forComponent:1];
    [self.pickerExample2TextField addPickerValue:@"#0000FF" forTitle:@"Blue" forComponent:1];
    [self.pickerExample2TextField addPickerValue:@"#FF0000" forTitle:@"Red" forComponent:2];
    [self.pickerExample2TextField addPickerValue:@"#00FF00" forTitle:@"Green" forComponent:2];
    [self.pickerExample2TextField addPickerValue:@"#0000FF" forTitle:@"Blue" forComponent:2];
    
    // Advanced picker
    [self.pickerExample3TextField setPlaceholder:@"Please pick these values"];
    [self.pickerExample3TextField setFormat:@"%@ -> %@"];
    [self.pickerExample3TextField addPickerValue:[NSNumber numberWithBool:YES] forTitle:@"Yes" forComponent:0];
    [self.pickerExample3TextField addPickerValue:[NSNumber numberWithBool:NO] forTitle:@"No" forComponent:0];
    [self.pickerExample3TextField addPickerValue:[NSURL URLWithString:@"http://www.google.com"] forTitle:@"Google" forComponent:1];
    [self.pickerExample3TextField addPickerValue:[NSURL URLWithString:@"http://www.yahoo.com"] forTitle:@"Yahoo" forComponent:1];
    [self.pickerExample3TextField addPickerValue:[NSURL URLWithString:@"http://www.bing.com"] forTitle:@"Bing" forComponent:1];
}

@end
