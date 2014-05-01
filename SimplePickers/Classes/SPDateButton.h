//
//  SPDateButton.h
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 23/03/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPDateButton : UIButton

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (NSDate *)currentSelectedValue;

@end
