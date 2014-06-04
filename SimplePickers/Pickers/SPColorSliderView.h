//
//  SPColorSliderView.h
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 18/05/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SPColorSliderDisplay) {
    SPColorSliderDisplayPourcent = 1,
    SPColorSliderDisplayDecimal,
    SPColorSliderDisplayHexadecimal
};

@interface SPColorSliderView : UIView

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic) float value;

@property (nonatomic, assign) SPColorSliderDisplay labelDisplay;

@end
