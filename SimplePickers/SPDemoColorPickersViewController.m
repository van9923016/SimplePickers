//
//  SPDemoColorPickersViewController.m
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 31/03/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import "SPDemoColorPickersViewController.h"
#import "SPColorTextField.h"

@interface SPDemoColorPickersViewController ()

@property (nonatomic, strong) IBOutlet SPColorTextField *colorTextField;

@end

@implementation SPDemoColorPickersViewController

-(IBAction)doApply:(id)sender
{
    NSString *message = @"";
    
    message = [message stringByAppendingFormat:@"colorTextField [%@]\n", [self.colorTextField color]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Results" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /////////////////////
    // SPColorTextField
    ////////////////
    
    // Color TextField
    [self.colorTextField setColor:[UIColor blueColor]];
}

@end
