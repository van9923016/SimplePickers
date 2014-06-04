//
//  SPColorTextField.m
//  SimplePickers
//
//  Created by Thomas Bui-Tho on 04/05/14.
//  Copyright (c) 2014 Simpleous. All rights reserved.
//

#import "SPColorTextField.h"
#import "SPColorGradientView.h"
#import "SPColorSliderView.h"

#define INPUT_VIEW_PADDING 10.0

@interface SPColorTextField ()

@property (nonatomic, strong) UIView *colorView;

@property (nonatomic, strong) UISegmentedControl *inputSegmentedControl;
@property (nonatomic, strong) UIToolbar *inputToolbar;

@property (nonatomic, strong) UIView *inputContainers;

@property (nonatomic, strong) UIView *slidersContainer;
@property (nonatomic, strong) SPColorSliderView *redSlider;
@property (nonatomic, strong) SPColorSliderView *greenSlider;
@property (nonatomic, strong) SPColorSliderView *blueSlider;
@property (nonatomic, strong) SPColorSliderView *alphaSlider;

@property (nonatomic, strong) UIView *gradientContainer;
@property (nonatomic, strong) SPColorGradientView *gradientView;

@end

@implementation SPColorTextField

#pragma mark - Lazy loading

-(UIView *)colorView
{
    if (!_colorView)
    {
        _colorView = [[UIView alloc] initWithFrame:self.bounds];
        UITapGestureRecognizer *simpleTapGestureRecognier = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSimpleTap:)];
        [_colorView addGestureRecognizer:simpleTapGestureRecognier];
    }
    return _colorView;
}

-(UISegmentedControl *)inputSegmentedControl
{
    if (!_inputSegmentedControl)
    {
        NSArray *items = [NSArray arrayWithObjects:
                          NSLocalizedString(@"Sliders", nil),
                          NSLocalizedString(@"Gradient", nil),
                          nil];
        _inputSegmentedControl = [[UISegmentedControl alloc] initWithItems:items];
        [_inputSegmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
        [_inputSegmentedControl setSelectedSegmentIndex:0];
        
        [_inputSegmentedControl addTarget:self action:@selector(inputSegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _inputSegmentedControl;
}

-(UIToolbar *)inputToolbar
{
    if (!_inputToolbar)
    {
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                    target:self
                                                                                    action:@selector(doClickCancel:)];
        UIBarButtonItem *spaceItemLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil
                                                                                       action:NULL];
        UIBarButtonItem *segmentedItem = [[UIBarButtonItem alloc] initWithCustomView:self.inputSegmentedControl];
        UIBarButtonItem *spaceItemRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                        target:nil
                                                                                        action:NULL];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                  target:self
                                                                                  action:@selector(doClickDone:)];
        
        _inputToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 44.0)];
        [_inputToolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [_inputToolbar setItems:@[cancelItem, spaceItemLeft, segmentedItem, spaceItemRight, doneItem]];
    }
    return _inputToolbar;
}

-(UIView *)inputContainers
{
    if (!_inputContainers)
    {
        _inputContainers = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [_inputContainers setBackgroundColor:[UIColor whiteColor]];
        
        [_inputContainers setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return _inputContainers;
}

-(UIView *)slidersContainer
{
    if (!_slidersContainer)
    {
        _slidersContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [_slidersContainer setBackgroundColor:[UIColor whiteColor]];
        
        [_slidersContainer setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        UIView *inputZone = [self insertInputZoneInContainer:_slidersContainer];
        
        self.redSlider = [self insertInputSliderInContainer:inputZone fromBottomOf:nil];
        [self.redSlider.slider setMinimumTrackTintColor:[UIColor redColor]];
        
        self.greenSlider = [self insertInputSliderInContainer:inputZone fromBottomOf:self.redSlider];
        [self.greenSlider.slider setMinimumTrackTintColor:[UIColor greenColor]];
        
        self.blueSlider = [self insertInputSliderInContainer:inputZone fromBottomOf:self.greenSlider];
        [self.blueSlider.slider setMinimumTrackTintColor:[UIColor blueColor]];
        
        self.alphaSlider = [self insertInputSliderInContainer:inputZone fromBottomOf:self.blueSlider];
        [self.alphaSlider.slider setMinimumTrackTintColor:[UIColor blackColor]];
    }
    return _slidersContainer;
}

-(UIView *)gradientContainer
{
    if (!_gradientContainer)
    {
        _gradientContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [_gradientContainer setBackgroundColor:[UIColor whiteColor]];
        
        [_gradientContainer setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        UIView *inputZone = [self insertInputZoneInContainer:_gradientContainer];
        self.gradientView = [[SPColorGradientView alloc] initWithFrame:CGRectZero];
        [self.gradientView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [inputZone addSubview:self.gradientView];
    }
    return _gradientContainer;
}

#pragma mark - Factory

- (SPColorSliderView *)insertInputSliderInContainer:(UIView *)containerView fromBottomOf:(SPColorSliderView *)previousSliderView
{
    SPColorSliderView *sliderView = [[SPColorSliderView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSliderLabel:)];
    [sliderView.label setUserInteractionEnabled:YES];
    [sliderView.label addGestureRecognizer:tapGesture];
    [sliderView.slider addTarget:self action:@selector(slidersValueChanged:) forControlEvents:UIControlEventValueChanged];
    [containerView addSubview:sliderView];
    
    [sliderView setLabelDisplay:SPColorSliderDisplayHexadecimal];
    
    [sliderView setTranslatesAutoresizingMaskIntoConstraints:NO];

    if (previousSliderView)
    {
        [containerView addConstraint:[NSLayoutConstraint constraintWithItem:sliderView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:previousSliderView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1
                                                                   constant:0]];
    }
    else
    {
        [containerView addConstraint:[NSLayoutConstraint constraintWithItem:sliderView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:containerView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1
                                                                   constant:0]];
    }
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:sliderView
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeWidth
                                                             multiplier:1
                                                               constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:sliderView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1
                                                               constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:sliderView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:0.25
                                                               constant:0]];
    
    return sliderView;
}

- (UIView *)insertInputZoneInContainer:(UIView *)containerView
{
    UIView *inputZone = [[UIView alloc] initWithFrame:CGRectZero];
    [inputZone setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [containerView addSubview:inputZone];
    
    // Left padding
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:inputZone
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1
                                                               constant:INPUT_VIEW_PADDING]];
    
    // Top padding
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:inputZone
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1
                                                               constant:INPUT_VIEW_PADDING]];
    
    // Right padding
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:inputZone
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeWidth
                                                             multiplier:1
                                                               constant:-2 * INPUT_VIEW_PADDING]];
    
    // Bottom padding
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:inputZone
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1
                                                               constant:-2 * INPUT_VIEW_PADDING]];
    
    return inputZone;
}

#pragma mark - Values

-(UIColor *)currentInputColor
{
    UIColor *color = [UIColor colorWithRed:[self.redSlider value]
                                     green:[self.greenSlider value]
                                      blue:[self.blueSlider value]
                                     alpha:[self.alphaSlider value]];
    
    return color;
}

-(void)updateSlidersWithColor:(UIColor *)color
{
    if (color)
    {
        unsigned long numComponents = CGColorGetNumberOfComponents([color CGColor]);
        
        if (numComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents([color CGColor]);
            CGFloat red = components[0];
            CGFloat green = components[1];
            CGFloat blue = components[2];
            CGFloat alpha = components[3];
            
            [self.redSlider setValue:red];
            [self.greenSlider setValue:green];
            [self.blueSlider setValue:blue];
            [self.alphaSlider setValue:alpha];
        }
    }
}

-(void)setColor:(UIColor *)color
{
    _color = color;
    
    UIColor *backgroundColor = nil;
    if (_color)
    {
        // Update inputs
        [self updateSlidersWithColor:_color];
        
        // Update display
        backgroundColor = _color;
    }
    [self.colorView setBackgroundColor:backgroundColor];
}

#pragma mark - Actions

-(IBAction)doClickCancel:(id)sender
{
    if (self.color)
    {
        // Reset inputs
        [self setColor:self.color];
    }
    
    [self resignFirstResponder];
}

-(IBAction)doClickDone:(id)sender
{
    // Set new value
    [self setColor:[self currentInputColor]];
    
    [self resignFirstResponder];
}

-(IBAction)inputSegmentedControlValueChanged:(id)sender
{
    if ([sender isKindOfClass:[UISegmentedControl class]])
    {
        UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
        
        [self.slidersContainer setHidden:YES];
        [self.gradientContainer setHidden:YES];
        
        switch ([segmentedControl selectedSegmentIndex]) {
            case 0:
                [self.slidersContainer setHidden:NO];
                break;
            case 1:
                [self.gradientContainer setHidden:NO];
                break;
                
            default:
                break;
        }
    }
}

-(IBAction)slidersValueChanged:(id)sender
{
    [self.colorView setBackgroundColor:[self currentInputColor]];
}

- (IBAction)tapSliderLabel:(id)sender
{
    SPColorSliderDisplay display = SPColorSliderDisplayPourcent;
    switch ([self.redSlider labelDisplay]) {
        case SPColorSliderDisplayPourcent:
            display = SPColorSliderDisplayDecimal;
            break;
        case SPColorSliderDisplayDecimal:
            display = SPColorSliderDisplayHexadecimal;
            break;
        case SPColorSliderDisplayHexadecimal:
            display = SPColorSliderDisplayPourcent;
            break;
            
        default:
            break;
    }
    
    [self.redSlider setLabelDisplay:display];
    [self.greenSlider setLabelDisplay:display];
    [self.blueSlider setLabelDisplay:display];
    [self.alphaSlider setLabelDisplay:display];
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

#pragma mark - UITapGestureRecognizer

-(IBAction)didSimpleTap:(id)sender
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
    [self setPlaceholder:nil];
    [self setText:nil];
    [self setBorderStyle:UITextBorderStyleLine];
    
    [self setInputAccessoryView:self.inputToolbar];
    [self setInputView:self.inputContainers];
    
    [self setLeftViewMode:UITextFieldViewModeAlways];
    [self setLeftView:self.colorView];
    
    [self.inputContainers addSubview:self.slidersContainer];
    [self.inputContainers addSubview:self.gradientContainer];
    
    [self inputSegmentedControlValueChanged:self.inputSegmentedControl];
    [self setColor:nil];
}

@end
