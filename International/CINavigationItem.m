//
//  CINavigationItem.m
//  International
//
//  Created by Dimitry Bentsionov on 7/23/13.
//  Copyright (c) 2013 Carnegie Museums. All rights reserved.
//

#import "CINavigationItem.h"
#import "CIBorderedButton.h"

@implementation CINavigationItem

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Set custom label to be the title view
        UILabel *titleLbl = [[UILabel alloc] init];
        titleLbl.text = self.title;
        titleLbl.textColor = [UIColor colorFromHex:kCIWhiteTextColor];
        titleLbl.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
        [titleLbl sizeToFit];
        self.titleView = titleLbl;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    // Update lbl size
    UILabel *lbl = (UILabel *)self.titleView;
    if (lbl != nil) {
        lbl.text = title;
        [lbl sizeToFit];
    }
}

- (void)setLeftBarButtonType:(CINavigationItemLeftBarButtonType)type target:(id)target action:(SEL)action {
    CGSize buttonSize = (CGSize){34.0f, 34.0f};
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 2.5f);
    switch (type) {
        case CINavigationItemLeftBarButtonTypeBack: {
            UIView *buttonView = [self customViewForButtonWithImage:[UIImage imageNamed:@"nav_back"]
                                                   highlightedImage:[UIImage imageNamed:@"nav_back_on"]
                                                               size:buttonSize
                                                         edgeInsets:edgeInsets
                                                             target:target
                                                             action:action];
            UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
            [self setLeftBarButtonItem:menuButton];
            break;
        }
    }
}

- (void)setRightBarButtonType:(CINavigationItemRightBarButtonType)type target:(id)target action:(SEL)action {
    CGSize buttonSize = (CGSize){34.0f, 34.0f};
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    switch (type) {
        case CINavigationItemRightBarButtonTypeOpenInSafari: {
            UIView *buttonView = [self customViewForButtonWithImage:[UIImage imageNamed:@"button_open_safari"]
                                                   highlightedImage:[UIImage imageNamed:@"button_open_safari_on"]
                                                               size:buttonSize
                                                         edgeInsets:edgeInsets
                                                             target:target
                                                             action:action];
            UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
            [self setRightBarButtonItem:menuButton];
            break;
        }
        case CINavigationItemRightBarButtonTypeSocial: {
            // Init buttons
            CIBorderedButton *button1 = [CIBorderedButton buttonWithType:UIButtonTypeCustom];
            button1.frame = (CGRect){{39.0f, 5.0f}, {34.0f, 34.0f}};
            [button1 setImage:[UIImage imageNamed:@"nav_twitter"] forState:UIControlStateNormal];
            [button1 setImage:[UIImage imageNamed:@"nav_twitter_on"] forState:UIControlStateHighlighted];
            [button1 setContentMode:UIViewContentModeCenter];
            [button1 setContentEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 2.5f)];
            [button1 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            button1.tag = 1;

            CIBorderedButton *button2 = [CIBorderedButton buttonWithType:UIButtonTypeCustom];
            button2.frame = (CGRect){{0, 5}, {34.0f, 34.0f}};
            [button2 setImage:[UIImage imageNamed:@"nav_facebook"] forState:UIControlStateNormal];
            [button2 setImage:[UIImage imageNamed:@"nav_facebook_on"] forState:UIControlStateHighlighted];
            [button2 setContentMode:UIViewContentModeCenter];
            [button2 setContentEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 7.5f)];
            [button2 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

            // Init view
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 73.0f, 34.0f)];
            [view addSubview:button1];
            [view addSubview:button2];
            
            UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:view];
            [self setRightBarButtonItem:menuButton];
            break;
        }
    }
}

- (UIView *)customViewForButtonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage size:(CGSize)size edgeInsets:(UIEdgeInsets)edgeInsets target:(id)target action:(SEL)action {
    // Init button
    CIBorderedButton *button = [CIBorderedButton buttonWithType:UIButtonTypeCustom];
    button.frame = (CGRect){{0, 5}, size};
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [button setContentMode:UIViewContentModeCenter];
    [button setContentEdgeInsets:edgeInsets];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // Init view
    UIView *view = [[UIView alloc] initWithFrame:button.frame];
    [view addSubview:button];
    
    return view;
}

@end