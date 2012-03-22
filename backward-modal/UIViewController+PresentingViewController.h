//
//  UIViewController+PresentingViewController.h
//  backward-modal
//
//  Created by Apirom Na Nakorn on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PresentingViewController)

@property (nonatomic, retain) UIViewController *iOS4_presentingViewController;
@property (nonatomic, retain) UIViewController *iOS4_presentedViewController;

- (void) iOS4_presentModalViewController: (UIViewController *) controller animated: (BOOL) animated;
- (void) iOS4_dismissModalViewControllerAnimated: (BOOL) animated;
- (void) iOS4_dealloc;


@end
