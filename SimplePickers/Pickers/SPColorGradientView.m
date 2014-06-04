//
//  SPColorGradientView.m
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 06/05/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import "SPColorGradientView.h"
#import "SPSliderView.h"

#define COLORS_VIEW_WIDTH 30.0
#define ALPHA_VIEW_WIDTH 30.0
#define MARGIN 15.0

//#define MIN_COLOR 0.0
//#define MAX_COLOR 100.0
//#define VARIABLE_COLOR -1

@interface SPColorGradientView ()

@property (nonatomic, strong) SPSliderView *colorsView;
@property (nonatomic, strong) SPSliderView *alphaView;
@property (nonatomic, strong) SPSliderView *tonesView;

@end

@implementation SPColorGradientView

#pragma mark - Lazy loading

-(SPSliderView *)colorsView
{
    if (!_colorsView)
    {
        _colorsView = [[SPSliderView alloc] initWithFrame:CGRectZero];
    }
    return _colorsView;
}

-(SPSliderView *)alphaView
{
    if (!_alphaView)
    {
        _alphaView = [[SPSliderView alloc] initWithFrame:CGRectZero];
    }
    return _alphaView;
}

-(SPSliderView *)tonesView
{
    if (!_tonesView)
    {
        _tonesView = [[SPSliderView alloc] initWithFrame:CGRectZero];
    }
    return _tonesView;
}

#pragma mark - Initialization

- (void)commonInitialization
{
    [self addSubview:self.colorsView];
    [self.colorsView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.colorsView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0
                                                      constant:COLORS_VIEW_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.colorsView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.colorsView
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.colorsView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];

    [self addSubview:self.alphaView];
    [self.alphaView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.alphaView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0
                                                      constant:ALPHA_VIEW_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.alphaView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.alphaView
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.colorsView
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:MARGIN]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.alphaView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];

    [self addSubview:self.tonesView];
    [self.tonesView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tonesView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tonesView
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.alphaView
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:MARGIN]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tonesView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tonesView
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:0]];
}

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

//-(void)layoutSubviews
//{
//    [self setNeedsDisplay];
//}
//
//- (CGFloat)initialValueForIndicator:(CGFloat)colorIndicator ascending:(BOOL)ascendingIndicator
//{
//    CGFloat color = 0;
//    
//    if (colorIndicator == MIN_COLOR)
//    {
//        color = MIN_COLOR;
//    }
//    else if (colorIndicator == MAX_COLOR)
//    {
//        color = MAX_COLOR;
//    }
//    else if (colorIndicator == VARIABLE_COLOR)
//    {
//        if (ascendingIndicator)
//        {
//            color = MIN_COLOR;
//        }
//        else
//        {
//            color = MAX_COLOR;
//        }
//    }
//    
//    return color;
//}
//
//- (NSArray *)colorSectionForRed:(CGFloat)redIndicator green:(CGFloat)greenIndicator blue:(CGFloat)blueIndicator ascending:(BOOL)ascendingIndicator
//{
//    NSMutableArray *colorSection = [NSMutableArray arrayWithCapacity:MAX_COLOR];
//    
//    CGFloat red = [self initialValueForIndicator:redIndicator ascending:ascendingIndicator];
//    CGFloat green = [self initialValueForIndicator:greenIndicator ascending:ascendingIndicator];
//    CGFloat blue = [self initialValueForIndicator:blueIndicator ascending:ascendingIndicator];
//    
//    for (int i = 0; i < MAX_COLOR; i++)
//    {
//        UIColor *color = [UIColor colorWithRed:(red/100.0) green:(green/100.0) blue:(blue/100.0) alpha:1.0];
//        [colorSection addObject:color];
//        
//        if (redIndicator == VARIABLE_COLOR)
//        {
//            if (ascendingIndicator)
//            {
//                red++;
//            }
//            else
//            {
//                red--;
//            }
//        }
//        
//        if (greenIndicator == VARIABLE_COLOR)
//        {
//            if (ascendingIndicator)
//            {
//                green++;
//            }
//            else
//            {
//                green--;
//            }
//        }
//        
//        if (blueIndicator == VARIABLE_COLOR)
//        {
//            if (ascendingIndicator)
//            {
//                blue++;
//            }
//            else
//            {
//                blue--;
//            }
//        }
//    }
//    
//    return colorSection;
//}
//
//- (void)drawRect:(CGRect)rect
//{
//    NSInteger numberOfColors = 6 * 100;
//    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:numberOfColors];
//    
//    [colors addObjectsFromArray:[self colorSectionForRed:MAX_COLOR green:VARIABLE_COLOR blue:MIN_COLOR ascending:YES]];
//    [colors addObjectsFromArray:[self colorSectionForRed:VARIABLE_COLOR green:MAX_COLOR blue:MIN_COLOR ascending:NO]];
//    [colors addObjectsFromArray:[self colorSectionForRed:MIN_COLOR green:MAX_COLOR blue:VARIABLE_COLOR ascending:YES]];
//    [colors addObjectsFromArray:[self colorSectionForRed:MIN_COLOR green:VARIABLE_COLOR blue:MAX_COLOR ascending:NO]];
//    [colors addObjectsFromArray:[self colorSectionForRed:VARIABLE_COLOR green:MIN_COLOR blue:MAX_COLOR ascending:YES]];
//    [colors addObjectsFromArray:[self colorSectionForRed:MAX_COLOR green:MIN_COLOR blue:VARIABLE_COLOR ascending:NO]];
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    if (numberOfColors > rect.size.height)
//    {
//        NSInteger stepSize = numberOfColors / rect.size.height;
//        
//        int cnt = 0;
//        for (int y = 0; y < rect.size.height; y++)
//        {
//            UIColor *color = [colors objectAtIndex:cnt];
//            cnt += stepSize;
//            CGContextSetFillColorWithColor(context, [color CGColor]);
//            CGContextFillRect(context, CGRectMake(0, y, rect.size.width, 1));
//        }
//    }
//    else
//    {
//        NSInteger stepHeight = rect.size.height / numberOfColors;
//        
//        int height = 0;
//        for (UIColor *color in colors)
//        {
//            CGContextSetFillColorWithColor(context, [color CGColor]);
//            CGContextFillRect(context, CGRectMake(0, height, rect.size.width, stepHeight));
//            
//            height+=stepHeight;
//        }
//        
//    }
//}

@end
