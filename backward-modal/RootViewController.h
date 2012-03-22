//
//  RootViewController.h
//  backward-modal
//
//  Created by Apirom Na Nakorn on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalController.h"

@interface RootViewController : UIViewController

@property (nonatomic, retain) ModalController *modal;

- (IBAction) buttonClicked: (id) sender;

@end
