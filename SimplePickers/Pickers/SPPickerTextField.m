//
//  SPPickerTextField.m
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 03/05/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import "SPPickerTextField.h"

@interface SPPickerTextField () <UIPickerViewDataSource, UIPickerViewDelegate, UIPickerViewAccessibilityDelegate>

@property (nonatomic, strong) UIPickerView *picker;

@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) NSArray *selectedValues;

@end

@implementation SPPickerTextField

#pragma mark - Lazy loading

-(UIPickerView *)picker
{
    if (!_picker)
    {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        [_picker setDataSource:self];
        [_picker setDelegate:self];
        [_picker setShowsSelectionIndicator:YES];
    }
    return _picker;
}

-(NSString *)format
{
    if (!_format)
    {
        NSMutableString *string = [NSMutableString string];
        for (int i = 0; i < [self.pickerValues count]; i++)
        {
            [string appendString:@"%@"];
            if (i < ([self.pickerValues count] - 1))
            {
                [string appendString:@" | "];
            }
        }
        _format = [[NSString alloc] initWithString:string];
    }
    return _format;
}

#pragma mark - Setters

-(void)setPickerValues:(NSArray *)pickerValues
{
    _pickerValues = pickerValues;
    
    [self.picker reloadAllComponents];
}

#pragma mark - Values

- (void)addPickerValue:(id)value forTitle:(NSString *)title forComponent:(NSInteger)component
{
    NSMutableArray *pickerValues = [NSMutableArray arrayWithArray:self.pickerValues];
    
    NSMutableArray *valuesForComponent = nil;
    
    if (component < [pickerValues count])
    {
        valuesForComponent = [NSMutableArray arrayWithArray:[pickerValues objectAtIndex:component]];
    }
    
    if (!valuesForComponent)
    {
        valuesForComponent = [NSMutableArray array];
        [pickerValues addObject:valuesForComponent];
    }
    
    NSMutableDictionary *newValue = [NSMutableDictionary dictionary];
    [newValue setObject:title forKey:PICKER_BUTTON_KEY_TITLE];
    [newValue setObject:value forKey:PICKER_BUTTON_KEY_VALUE];
    
    [valuesForComponent addObject:newValue];
    
    [pickerValues replaceObjectAtIndex:component withObject:valuesForComponent];
    
    [self setPickerValues:pickerValues];
}

- (NSArray *)currentSelectedValues
{
    return self.selectedValues;
}

- (void)updateCurrentSelectedValues
{
    NSMutableArray *currentSelectedValues = [NSMutableArray array];
    
    for (int component = 0; component < [self.picker numberOfComponents]; component++)
    {
        [currentSelectedValues addObject:[self currentSelectedValueForComponent:component]];
    }
    
    self.selectedValues = currentSelectedValues;
}

- (NSString *)currentSelectedTitleForComponent:(NSInteger)component
{
    return [self titleForRow:[self.picker selectedRowInComponent:component] forComponent:component];
}

- (id)currentSelectedValueForComponent:(NSInteger)component
{
    return [self valueForRow:[self.picker selectedRowInComponent:component] forComponent:component];
}

- (NSString *)stringWithFormat:(NSString *)format andArguments:(NSArray *)arguments
{
    NSRange range = NSMakeRange(0, [arguments count]);
    NSMutableData* data = [NSMutableData dataWithLength:sizeof(id) * [arguments count]];
    [arguments getObjects:(__unsafe_unretained id *)data.mutableBytes range:range];
    
    NSString *string = [[NSString alloc] initWithFormat:self.format arguments:data.mutableBytes];
    
    return string;
}

- (NSArray *)currentSelectedIndexes
{
    NSMutableArray *currentSelectedIndexes = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.picker numberOfComponents]; i++)
    {
        [currentSelectedIndexes addObject:[NSNumber numberWithInteger:[self.picker selectedRowInComponent:i]]];
    }
    return currentSelectedIndexes;
}

- (NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    
    if (self.pickerValues
        && component < [self.pickerValues count]
        && [[self.pickerValues objectAtIndex:component] isKindOfClass:[NSArray class]]
        && row < [[self.pickerValues objectAtIndex:component] count])
    {
        NSDictionary *entry = [[self.pickerValues objectAtIndex:component] objectAtIndex:row];
        title = [SPPickerTextField titleForEntry:entry];
    }
    
    return title;
}

- (id)valueForRow:(NSInteger)row forComponent:(NSInteger)component
{
    id value = [NSObject new];
    
    if (self.pickerValues
        && component < [self.pickerValues count]
        && [[self.pickerValues objectAtIndex:component] isKindOfClass:[NSArray class]]
        && row < [[self.pickerValues objectAtIndex:component] count])
    {
        NSDictionary *entry = [[self.pickerValues objectAtIndex:component] objectAtIndex:row];
        value = [SPPickerTextField valueForEntry:entry];
    }
    
    return value;
}

+ (NSString *)titleForEntry:(NSDictionary *)entry
{
    NSString *title = nil;
    if ([entry isKindOfClass:[NSDictionary class]])
    {
        title = [entry objectForKey:PICKER_BUTTON_KEY_TITLE];
    }
    return title;
}

+ (id)valueForEntry:(NSDictionary *)entry
{
    id value = nil;
    if ([entry isKindOfClass:[NSDictionary class]])
    {
        value = [entry objectForKey:PICKER_BUTTON_KEY_VALUE];
    }
    return value;
}

#pragma mark - Display

- (void)updateValues:(NSArray *)values
{
    NSString *text = nil;
    
    self.values = values;
    
    if (self.values)
    {
        [self updateCurrentSelectedValues];
        
        NSMutableArray *titleValues = [NSMutableArray array];
        for (int i = 0; i < [self.picker numberOfComponents]; i++)
        {
            NSString *titleValue = [self titleForRow:[[self.values objectAtIndex:i] integerValue] forComponent:i];
            [titleValues addObject:titleValue];
        }
        
        text = [self stringWithFormat:self.format andArguments:titleValues];
    }
    
    [self setText:text];
}

#pragma mark - Actions

-(IBAction)doClickCancel:(id)sender
{
    [self resignFirstResponder];
    
    if (self.values)
    {
        for (int i = 0; i < [self.picker numberOfComponents]; i++)
        {
            [self.picker selectRow:[[self.values objectAtIndex:i] integerValue] inComponent:i animated:NO];
        }
        [self updateValues:[self currentSelectedIndexes]];
    }
}

-(IBAction)doClickDone:(id)sender
{
    [self resignFirstResponder];
    
    [self updateValues:[self currentSelectedIndexes]];
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

#pragma mark - UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger numberOfComponents = 0;
    
    if (self.pickerValues)
    {
        numberOfComponents = [self.pickerValues count];
    }
    
    return numberOfComponents;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger numberOrRows = 0;
    
    if (self.pickerValues
        && component < [self.pickerValues count]
        && [self.pickerValues objectAtIndex:component]
        && [[self.pickerValues objectAtIndex:component] isKindOfClass:[NSArray class]])
    {
        numberOrRows = [[self.pickerValues objectAtIndex:component] count];
    }
    
    return numberOrRows;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = nil;
    
    title = [self titleForRow:row forComponent:component];
    
    return title;
}

#pragma mark - UIPickerViewDelegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
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
    [self setInputView:self.picker];

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

    [self updateValues:nil];
}

@end
