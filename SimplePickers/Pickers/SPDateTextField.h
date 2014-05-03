//
//  SPDateTextField.h
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 03/05/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPDateTextField : UITextField

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSDate *date;

@end
