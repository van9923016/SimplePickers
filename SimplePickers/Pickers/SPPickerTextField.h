//
//  SPPickerTextField.h
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 03/05/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PICKER_BUTTON_KEY_TITLE @"title"
#define PICKER_BUTTON_KEY_VALUE @"value"

@interface SPPickerTextField : UITextField

@property (nonatomic, strong) NSString *format;
@property (nonatomic, strong) NSArray *pickerValues;

- (void)addPickerValue:(id)value forTitle:(NSString *)title forComponent:(NSInteger)component;
- (NSArray *)currentSelectedValues;

@end
