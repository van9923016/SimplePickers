//
//  SPDateTextField.m
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 03/05/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import "SPDateTextField.h"

@interface SPDateTextField ()

@end

@implementation SPDateTextField

#pragma mark - Lazy loading

-(UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    }
    return _datePicker;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
    }
    return _dateFormatter;
}

#pragma mark - Values

-(void)setDate:(NSDate *)date
{
    _date = date;
    
    NSString *text = nil;
    if (_date)
    {
        [self.datePicker setDate:_date];
        text = [self.dateFormatter stringFromDate:_date];
    }
    [self setText:text];
}

#pragma mark - Actions

-(IBAction)doClickCancel:(id)sender
{
    if (self.date)
    {
        [self.datePicker setDate:self.date animated:NO];
        [self setDate:[self.datePicker date]];
    }

    [self resignFirstResponder];
}

-(IBAction)doClickDone:(id)sender
{
    [self setDate:[self.datePicker date]];

    [self resignFirstResponder];
}

#pragma mark - UITextField

-(CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectMake(0, 0, 0, 0);
}

-(BOOL)shouldChangeTextInRange:(UITextRange *)range replacementText:(NSString *)text
{
    return NO;
}

#pragma mark - UIControl

-(id)init
{
    if (self = [super init])
    {
        [self commonInitialization];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self commonInitialization];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self commonInitialization];
    }
    return self;
}

- (void)commonInitialization
{
    [self setInputView:self.datePicker];

    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(doClickCancel:)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:NULL];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(doClickDone:)];
    UIToolbar *inputAccessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 44.0)];
    [inputAccessoryView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [inputAccessoryView setItems:@[cancelItem, spaceItem, doneItem]];
    
    [self setInputAccessoryView:inputAccessoryView];
    
    [self setDate:nil];
}

@end
