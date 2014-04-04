//
//  SPDateButton.m
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 23/03/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import "SPDateButton.h"

@interface SPDateButton ()

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) NSDate *value;

@property (nonatomic, strong) UITextField *dateTextField;

@end

@implementation SPDateButton

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

-(NSDate *)currentSelectedValue
{
    return [self value];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    if (!self.value)
    {
        [self updateDate:nil];
    }
}

-(void)setDate:(NSDate *)date
{
    [self.datePicker setDate:date];
    
    [self updateDate:[self.datePicker date]];
}

- (void)updateDate:(NSDate *)date
{
    NSString *title = nil;
    
    self.value = date;
    
    if (self.value)
    {
        title = [self.dateFormatter stringFromDate:self.value];
    }
    
    if (!title || [@"" isEqualToString:title])
    {
        title = NSLocalizedString(self.placeholder, nil);
    }
    
    [self setTitle:title forState:UIControlStateNormal];
}

-(BOOL)isFirstResponder
{
    return [self.dateTextField isFirstResponder];
}

#pragma mark - Actions

-(IBAction)doClickCancel:(id)sender
{
    [self resignFirstResponder];
    
    if (self.value)
    {
        [self.datePicker setDate:self.value animated:NO];
        [self updateDate:[self.datePicker date]];
    }
}

-(IBAction)doClickDone:(id)sender
{
    [self resignFirstResponder];
    
    [self updateDate:[self.datePicker date]];
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([self isFirstResponder])
    {
        [self resignFirstResponder];
    }
    else
    {
        [self becomeFirstResponder];
    }
}

-(BOOL)resignFirstResponder
{
    return [self.dateTextField resignFirstResponder];
}

-(BOOL)becomeFirstResponder
{
    return [self.dateTextField becomeFirstResponder];
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
    self.placeholder = [self titleForState:UIControlStateNormal];

    self.dateTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.dateTextField setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.dateTextField];
    
    [self.dateTextField setInputView:self.datePicker];
    
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
    
    [self.dateTextField setInputAccessoryView:inputAccessoryView];
    
    [self updateDate:nil];
}

@end
