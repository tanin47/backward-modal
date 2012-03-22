//
//  UIViewController+PresentingViewController.m
//  backward-modal
//
//  Created by Apirom Na Nakorn on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <objc/runtime.h> 
#import <objc/message.h>



#import "UIViewController+PresentingViewController.h"


static char const * const PresentingViewControllerKey = "iOS4_presentingViewControllerKey";
static char const * const PresentedViewControllerKey = "iOS4_presentedViewControllerKey";


@implementation NSObject (Swizzle)

void MethodAdd(Class c, SEL dest, SEL source)
{
    Method destMethod = class_getInstanceMethod(c, dest);
    Method sourceMethod = class_getInstanceMethod(c, source);
    class_addMethod(c, dest, method_getImplementation(sourceMethod), method_getTypeEncoding(sourceMethod));
}

void MethodSwizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}

@end


@implementation UIViewController (PresentingViewController)


@dynamic iOS4_presentingViewController;
@dynamic iOS4_presentedViewController;


- (UIViewController *) iOS4_presentingViewController 
{
    NSLog(@"Get presenting");
    return objc_getAssociatedObject(self, PresentingViewControllerKey);
}


- (void)setIOS4_presentingViewController: (UIViewController *) newObj 
{
    NSLog(@"Set presenting");
    objc_setAssociatedObject(self, PresentingViewControllerKey, newObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIViewController *) iOS4_presentedViewController 
{
    NSLog(@"Get presented");
    return objc_getAssociatedObject(self, PresentedViewControllerKey);
}


- (void)setIOS4_presentedViewController: (UIViewController *) newObj 
{
    NSLog(@"Set presented");
    objc_setAssociatedObject(self, PresentedViewControllerKey, newObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void) iOS4_presentModalViewController: (UIViewController *) controller animated: (BOOL) animated
{
    NSLog(@"Present");
    
    self.iOS4_presentedViewController = controller;
    self.iOS4_presentedViewController.iOS4_presentingViewController = self;
    
    [self iOS4_presentModalViewController:controller animated:animated];
}


- (void) iOS4_dismissModalViewControllerAnimated: (BOOL) animated
{
     NSLog(@"Dismiss");
    
    self.iOS4_presentedViewController.iOS4_presentingViewController = nil;
    self.iOS4_presentedViewController = nil;
    [self iOS4_dismissModalViewControllerAnimated:animated];
}

- (void) iOS4_dealloc
{
    NSLog(@"Dealloc");
    
    self.iOS4_presentedViewController = nil;
    self.iOS4_presentingViewController = nil;
    [self iOS4_dealloc];
}



+ (void) load 
{
    BOOL isIOS5 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0;

    if (isIOS5) return;
    
    NSLog(@"Methods swizzled");
    
    // Prepare property
    MethodAdd([self class],
                  @selector(presentedViewController),
                  @selector(iOS4_presentedViewController));
    
    MethodAdd([self class],
                  @selector(setPresentedViewController:),
                  @selector(setIOS4_presentedViewController:));
    
    
    // Prepare property
    MethodAdd([self class],
                  @selector(presentingViewController),
                  @selector(iOS4_presentingViewController));
    
    MethodAdd([self class],
                  @selector(setPresentingViewController:),
                  @selector(setIOS4_presentingViewController:));
    
    
    // Presenting and Dismissing
    MethodSwizzle([self class],
                  @selector(presentModalViewController:animated:),
                  @selector(iOS4_presentModalViewController:animated:));
    
    MethodSwizzle([self class],
                  @selector(dismissModalViewControllerAnimated:),
                  @selector(iOS4_dismissModalViewControllerAnimated:));
    
    MethodSwizzle([self class],
                  @selector(dealloc:),
                  @selector(iOS4_dealloc:));
}


@end






