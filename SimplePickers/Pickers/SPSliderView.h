//
//  SPSliderView.h
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 24/05/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPSliderView : UIControl

@property (nonatomic, assign) float xValue;
@property (nonatomic, assign) float minimumXValue;
@property (nonatomic, assign) float maximumXValue;

@property (nonatomic, assign) float yValue;
@property (nonatomic, assign) float minimumYValue;
@property (nonatomic, assign) float maximumYValue;

@end
