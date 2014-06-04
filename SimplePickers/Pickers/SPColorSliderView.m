//
//  SPColorSliderView.m
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 18/05/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import "SPColorSliderView.h"

#define LABEL_WIDTH 50.0

@implementation SPColorSliderView

#pragma mark - Lazy loading

-(UISlider *)slider
{
    if (!_slider)
    {
        _slider = [[UISlider alloc] initWithFrame:CGRectZero];
        
        [_slider setMinimumValue:0];
        [_slider setMaximumValue:1];
        
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

-(UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        [_label setTextAlignment:NSTextAlignmentRight];
        [_label setAdjustsFontSizeToFitWidth:YES];
    }
    return _label;
}

#pragma mark - Actions

-(IBAction)sliderValueChanged:(id)sender
{
    [self updateLabelDisplay];
}

- (void)updateLabelDisplay
{
    switch (self.labelDisplay) {
        case SPColorSliderDisplayPourcent:
            [self.label setText:[NSString stringWithFormat:@"%.0f%%", [self value] * 100.0]];
            break;
        case SPColorSliderDisplayDecimal:
            [self.label setText:[NSString stringWithFormat:@"%i", (int)([self.slider value] * 255.0)]];
            break;
        case SPColorSliderDisplayHexadecimal:
            [self.label setText:[NSString stringWithFormat:@"0x%02X", (unsigned int)([self.slider value] * 255.0)]];
            break;
            
        default:
            break;
    }
}

#pragma mark - Values

-(float)value
{
    return [self.slider value];
}

-(void)setValue:(float)value
{
    [self.slider setValue:value];
    
    [self updateLabelDisplay];
}

-(void)setLabelDisplay:(SPColorSliderDisplay)labelDisplay
{
    _labelDisplay = labelDisplay;
    
    [self updateLabelDisplay];
}

#pragma mark - UIView

-(id)init
{
    self = [super init];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
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

- (void)commonInitialization
{
    self.labelDisplay = SPColorSliderDisplayPourcent;
    
    [self addSubview:self.label];
    [self.label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0
                                                      constant:LABEL_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    
    [self addSubview:self.slider];
    [self.slider setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.slider
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.slider
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.slider
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.label
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.slider
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
}


@end
