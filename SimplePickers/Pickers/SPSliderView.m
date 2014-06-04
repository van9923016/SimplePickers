//
//  SPSliderView.m
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 24/05/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import "SPSliderView.h"

@implementation SPSliderView

#pragma mark - Initialization

- (void)commonInitialization
{
    [self setBackgroundColor:[UIColor orangeColor]];
    
    _xValue = 0.0;
    _minimumXValue = 0.0;
    _maximumXValue = 100.0;

    _yValue = 0.0;
    _minimumYValue = 0.0;
    _maximumYValue = 100.0;
}

#pragma mark - UIControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
